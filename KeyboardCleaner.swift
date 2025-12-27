import SwiftUI
import AppKit

struct KeyboardCleaner: View {
    @State private var isActive = false
    @State private var message = ""
    @State private var tip = ""
    @State private var showToast = false
    @State private var toastTitle = ""
    @State private var toastDescription = ""
    @State private var escCount = 0
    @State private var escTimer: Timer?
    
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
        ZStack {
            // Background
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Header
                VStack(spacing: 8) {
                    Text("SudoCleaner")
                        .font(.system(size: 36, weight: .black))
                        .foregroundColor(.foreground)
                    
                    Text(isActive ? message : "Give your MacBook keys some love 💕")
                        .font(.system(size: 18))
                        .foregroundColor(.mutedForeground)
                }
                
                // Keyboard illustration
                KeyboardIcon(isActive: isActive)
                    .frame(width: 256, height: 171)
                    .padding(.vertical, 32)
                
                // Timer
                if isActive {
                    CleaningTimer(isActive: isActive)
                }
                
                // Action button
                CleanButton(isActive: isActive) {
                    toggleCleaning()
                }
                
                // Tips / Instructions
                Group {
                    if isActive {
                        VStack(spacing: 8) {
                            Text("💡 Pro tip:")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.secondaryForeground)
                            
                            Text(tip)
                                .font(.system(size: 14))
                                .foregroundColor(.secondaryForeground.opacity(0.8))
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.5))
                        .cornerRadius(12)
                    } else {
                        VStack(spacing: 12) {
                            Text("All keyboard input will be disabled")
                                .font(.system(size: 14))
                                .foregroundColor(.mutedForeground)
                            
                            HStack(spacing: 4) {
                                Text("Press")
                                    .font(.system(size: 12))
                                    .foregroundColor(.mutedForeground.opacity(0.6))
                                
                                Text("ESC")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.mutedForeground.opacity(0.6))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.muted)
                                    .cornerRadius(4)
                                
                                Text("3 times quickly to stop")
                                    .font(.system(size: 12))
                                    .foregroundColor(.mutedForeground.opacity(0.6))
                            }
                        }
                    }
                }
                .opacity(isActive ? 1.0 : 0.6)
                .animation(.easeInOut(duration: 0.5), value: isActive)
                
            }
            .padding(32)
            .frame(maxWidth: 500)
            
            // Toast notification
            if showToast {
                ToastView(title: toastTitle, description: toastDescription)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1000)
            }
        }
        .onAppear {
            setupKeyboardMonitoring()
        }
        .onChange(of: isActive) { oldValue, newValue in
            if newValue {
                startTipCycling()
            } else {
                stopTipCycling()
            }
        }
    }
    
    private func toggleCleaning() {
        if !isActive {
            isActive = true
            message = funnyMessages.randomElement() ?? funnyMessages[0]
            tip = cleaningTips.randomElement() ?? cleaningTips[0]
            showToast(title: "Cleaning Mode Activated! 🧹", description: "Press ESC 3 times quickly to stop")
        } else {
            isActive = false
            escCount = 0
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
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            if isActive {
                tip = cleaningTips.randomElement() ?? cleaningTips[0]
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func stopTipCycling() {
        // Timer will invalidate itself when isActive becomes false
    }
    
    private func setupKeyboardMonitoring() {
        // Note: For full keyboard blocking, you may need accessibility permissions
        // This implementation intercepts ESC key presses when cleaning is active
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [self] event in
            if isActive {
                if event.keyCode == 53 { // ESC key
                    escCount += 1
                    escTimer?.invalidate()
                    
                    if escCount >= 3 {
                        DispatchQueue.main.async {
                            toggleCleaning()
                        }
                        escCount = 0
                    } else {
                        escTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                            escCount = 0
                        }
                    }
                }
                return nil // Consume the event
            }
            return event
        }
    }
}

#Preview {
    KeyboardCleaner()
}

