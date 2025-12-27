import SwiftUI
import AppKit
import ApplicationServices

struct KeyboardCleaner: View {
    @State private var isActive = false
    @State private var message = ""
    @State private var tip = ""
    @State private var showToast = false
    @State private var toastTitle = ""
    @State private var toastDescription = ""
    @State private var tipTimer: Timer?
    @State private var eventTap: CFMachPort?
    @State private var runLoopSource: CFRunLoopSource?
    @State private var hasCheckedPermissions = false
    @State private var cachedPermissionStatus: Bool = false
    
    // Use a class wrapper for the callback
    private class KeyboardBlockingManager {
        var isActive: Bool = false
        
        func handleEvent(_ event: CGEvent) -> CGEvent? {
            guard isActive else {
                return event
            }
            
            // Get the event type
            let eventType = event.type
            
            // Block ALL keyboard-related events
            // This includes: keyDown, keyUp, flagsChanged (for modifier keys)
            // Function keys (F1-F12), ESC, and system function keys (brightness, volume, etc.)
            // all generate keyDown/keyUp events that we can intercept
            if eventType == .keyDown || eventType == .keyUp || eventType == .flagsChanged {
                // Block ALL keyboard events - no exceptions
                // This includes ESC (53), function keys F1-F12 (122-131), 
                // system function keys (brightness, volume, etc.), and all other keys
                return nil
            }
            
            // Allow non-keyboard events (mouse, etc.) to pass through
            return event
        }
    }
    
    @State private var blockingManager = KeyboardBlockingManager()
    
    private let funnyMessages = [
        "Time to evict those crumb tenants! 🍪",
        "Your keys deserve a spa day too! 💆",
        "Dust bunnies, your time is up! 🐰",
        "Making your keyboard shine brighter than your future! ✨",
        "Operation: Clean Sweep activated! 🎯",
    ]
    
    private let cleaningTips = [
        "Gently wipe between the keys",
        "Use compressed air for stubborn crumbs",
        "A soft brush works wonders",
        "Don't forget the edges!",
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let scale = min(geometry.size.width / 600, geometry.size.height / 700, 1.0)
            let baseSpacing: CGFloat = 32
            let basePadding: CGFloat = 32
            let keyboardSize = min(geometry.size.width * 0.4, 256 * scale, geometry.size.height * 0.25)
            
            ZStack {
                // Background
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: baseSpacing * scale) {
                        // Header
                        VStack(spacing: 8 * scale) {
                            Text("SudoCleaner")
                                .font(.system(size: max(28 * scale, 24), weight: .black))
                                .foregroundColor(.foreground)
                            
                            Text(isActive ? message : "Give your MacBook keys some love 💕")
                                .font(.system(size: max(16 * scale, 14)))
                                .foregroundColor(.mutedForeground)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, basePadding * scale)
                        }
                        
                        // Keyboard illustration
                        KeyboardIcon(isActive: isActive)
                            .frame(width: keyboardSize, height: keyboardSize * 0.667)
                            .padding(.vertical, 24 * scale)
                        
                        // Action button
                        CleanButton(isActive: isActive, scale: scale) {
                            toggleCleaning()
                        }
                        
                        // Tips / Instructions
                        Group {
                            if isActive {
                                VStack(spacing: 8 * scale) {
                                    Text("💡 Pro tip:")
                                        .font(.system(size: max(14 * scale, 12), weight: .semibold))
                                        .foregroundColor(.secondaryForeground)
                                    
                                    Text(tip)
                                        .font(.system(size: max(14 * scale, 12)))
                                        .foregroundColor(.secondaryForeground.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(basePadding * scale * 0.75)
                                .background(Color.secondary.opacity(0.5))
                                .cornerRadius(12 * scale)
                                .padding(.horizontal, basePadding * scale)
                            } else {
                                VStack(spacing: 12 * scale) {
                                    Text("All keyboard input will be disabled")
                                        .font(.system(size: max(14 * scale, 12)))
                                        .foregroundColor(.mutedForeground)
                                        .multilineTextAlignment(.center)
                                    
                                }
                                .padding(.horizontal, basePadding * scale)
                            }
                        }
                        .opacity(isActive ? 1.0 : 0.6)
                        .animation(.easeInOut(duration: 0.5), value: isActive)
                        
                        Spacer(minLength: 20 * scale)
                    }
                    .padding(basePadding * scale)
                    .frame(maxWidth: min(geometry.size.width, 600), maxHeight: .infinity)
                    .frame(width: geometry.size.width)
                }
                
                // Toast notification
                if showToast {
                    ToastView(title: toastTitle, description: toastDescription, scale: scale)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .zIndex(1000)
                }
            }
        }
        .onAppear {
            setupKeyboardMonitoring()
            setupPermissionObserver()
        }
        .onChange(of: isActive) { newValue in
            blockingManager.isActive = newValue
            if newValue {
                startTipCycling()
                startKeyboardBlocking()
            } else {
                stopTipCycling()
                stopKeyboardBlocking()
            }
        }
        .onDisappear {
            stopTipCycling()
            stopKeyboardBlocking()
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    private func toggleCleaning() {
        if !isActive {
            // Refresh permission status before starting
            hasCheckedPermissions = false
            
            // Check permissions before starting
            if !hasAccessibilityPermissions() {
                // Request permissions (will show system dialog if needed)
                requestAccessibilityPermissions()
                showToast(title: "Permission Required", description: "Please enable SudoCleaner in Accessibility settings first")
                return
            }
            
            isActive = true
            message = funnyMessages.randomElement() ?? funnyMessages[0]
            tip = cleaningTips.randomElement() ?? cleaningTips[0]
            showToast(title: "Cleaning Mode Activated! 🧹", description: "All keyboard input is now disabled. Click 'Stop Cleaning' to re-enable.")
        } else {
            isActive = false
            showToast(title: "All done! ✨", description: "Your keyboard is sparkling clean!")
        }
    }
    
    private func showToast(title: String, description: String) {
        toastTitle = title
        toastDescription = description
        withAnimation {
            showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                showToast = false
            }
        }
    }
    
    private func startTipCycling() {
        tipTimer?.invalidate()
        tipTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            if self.isActive {
                self.tip = self.cleaningTips.randomElement() ?? self.cleaningTips[0]
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func stopTipCycling() {
        tipTimer?.invalidate()
        tipTimer = nil
    }
    
    private func setupKeyboardMonitoring() {
        // Don't check permissions on launch - only check when user tries to use the feature
        // Initialize permission status cache
        _ = hasAccessibilityPermissions()
    }
    
    private func setupPermissionObserver() {
        // Listen for when the app becomes active to refresh permission status
        NotificationCenter.default.addObserver(
            forName: NSApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { _ in
            // Refresh permission status when app becomes active
            // This helps detect when user returns from System Settings
            self.hasCheckedPermissions = false
        }
    }
    
    private func hasAccessibilityPermissions() -> Bool {
        // Always check fresh status (don't use cache when explicitly checking)
        // This ensures we detect permission changes immediately
        let hasPermission = AXIsProcessTrusted()
        cachedPermissionStatus = hasPermission
        hasCheckedPermissions = true
        
        return hasPermission
    }
    
    private func requestAccessibilityPermissions() {
        // Always refresh permission status before requesting
        hasCheckedPermissions = false
        
        // Request with prompt (this will show system dialog)
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        _ = AXIsProcessTrustedWithOptions(options as CFDictionary)
        
        // Wait a moment and refresh the permission status
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Refresh the cached status
            self.hasCheckedPermissions = false
            let hasPermission = self.hasAccessibilityPermissions()
            
            // Only show alert if still not granted after the system prompt
            if !hasPermission {
                let alert = NSAlert()
                alert.messageText = "Accessibility Permission Required"
                alert.informativeText = "SudoCleaner needs accessibility permissions to disable your keyboard during cleaning.\n\nPlease:\n1. Click 'Open System Settings' below\n2. Find 'SudoCleaner' in the list\n3. Enable the toggle\n4. Click 'Stop Cleaning' and try again"
                alert.alertStyle = .informational
                alert.addButton(withTitle: "Open System Settings")
                alert.addButton(withTitle: "Cancel")
                
                if alert.runModal() == .alertFirstButtonReturn {
                    self.openAccessibilitySettings()
                }
            }
        }
    }
    
    private func openAccessibilitySettings() {
        // Try different URL schemes for different macOS versions
        var url: URL?
        
        // macOS 13+ (Ventura and later) - use the new System Settings URL
        if #available(macOS 13.0, *) {
            // Try the new System Settings URL
            url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")
            if url == nil {
                // Fallback for newer macOS
                url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")
            }
        } else {
            // macOS 12 and earlier
            url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")
        }
        
        if let url = url {
            NSWorkspace.shared.open(url)
        } else {
            // Final fallback
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))
        }
    }
    
    private func startKeyboardBlocking() {
        // Stop any existing event tap
        stopKeyboardBlocking()
        
        // Always re-check permissions (don't use cache)
        hasCheckedPermissions = false
        let hasPermission = hasAccessibilityPermissions()
        
        if !hasPermission {
            // Request permissions (will show system dialog if needed)
            requestAccessibilityPermissions()
            showToast(title: "Permission Required", description: "Please enable SudoCleaner in System Settings > Privacy & Security > Accessibility")
            return
        }
        
        // Create event tap to intercept ALL keyboard events including function keys and modifier keys
        // Function keys (F1-F12), ESC, and system function keys (brightness, volume, etc.) 
        // all generate keyDown/keyUp events that we can intercept
        let eventMask = CGEventMask(1 << CGEventType.keyDown.rawValue) | 
                       CGEventMask(1 << CGEventType.keyUp.rawValue) | 
                       CGEventMask(1 << CGEventType.flagsChanged.rawValue)
        
        blockingManager.isActive = isActive
        
        // Try cgAnnotatedSessionEventTap first - this captures more events including system function keys
        // If that fails, fall back to cgSessionEventTap
        var tapLocation: CGEventTapLocation = .cgAnnotatedSessionEventTap
        
        // Try with listenOnly first to see if we can capture events
        // Then switch to defaultTap to actually block them
        eventTap = CGEvent.tapCreate(
            tap: tapLocation,
            place: .headInsertEventTap,
            options: .defaultTap,  // Use defaultTap to actually block events
            eventsOfInterest: eventMask,
            callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                guard let refcon = refcon else {
                    return Unmanaged.passUnretained(event)
                }
                
                let manager = Unmanaged<KeyboardBlockingManager>.fromOpaque(refcon).takeUnretainedValue()
                
                if let result = manager.handleEvent(event) {
                    return Unmanaged.passUnretained(result)
                } else {
                    return nil // Block the event
                }
            },
            userInfo: Unmanaged.passUnretained(blockingManager).toOpaque()
        )
        
        // If cgAnnotatedSessionEventTap failed, try cgSessionEventTap as fallback
        if eventTap == nil {
            tapLocation = .cgSessionEventTap
            eventTap = CGEvent.tapCreate(
                tap: tapLocation,
                place: .headInsertEventTap,
                options: .defaultTap,
                eventsOfInterest: eventMask,
                callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                    guard let refcon = refcon else {
                        return Unmanaged.passUnretained(event)
                    }
                    
                    let manager = Unmanaged<KeyboardBlockingManager>.fromOpaque(refcon).takeUnretainedValue()
                    
                    if let result = manager.handleEvent(event) {
                        return Unmanaged.passUnretained(result)
                    } else {
                        return nil // Block the event
                    }
                },
                userInfo: Unmanaged.passUnretained(blockingManager).toOpaque()
            )
        }
        
        guard let eventTap = eventTap else {
            print("Failed to create event tap. Accessibility permissions may be required.")
            showToast(title: "Error", description: "Failed to create keyboard event tap. Please check accessibility permissions.")
            return
        }
        
        // Create run loop source
        runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        guard let runLoopSource = runLoopSource else {
            print("Failed to create run loop source")
            return
        }
        
        // Add to current run loop
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        
        // Enable the event tap
        CGEvent.tapEnable(tap: eventTap, enable: true)
        
        // Verify the event tap is enabled
        if !CGEvent.tapIsEnabled(tap: eventTap) {
            print("Warning: Event tap was not enabled properly. Retrying...")
            CGEvent.tapEnable(tap: eventTap, enable: true)
            
            // If still not enabled, there might be a permission issue
            if !CGEvent.tapIsEnabled(tap: eventTap) {
                print("Error: Event tap could not be enabled. Permissions may be insufficient.")
                showToast(title: "Warning", description: "Keyboard blocking may not work properly. Please check accessibility permissions.")
            }
        } else {
            print("Event tap enabled successfully. All keyboard events (including function keys) should now be blocked.")
        }
    }
    
    private func stopKeyboardBlocking() {
        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: false)
            self.eventTap = nil
        }
        
        if let runLoopSource = runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
            self.runLoopSource = nil
        }
    }
}

#Preview {
    KeyboardCleaner()
}

