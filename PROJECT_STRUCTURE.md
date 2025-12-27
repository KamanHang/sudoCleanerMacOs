# Keyboard Kaddy Swift - Project Structure

## Files Overview

### Core App Files
- **KeyboardKaddyApp.swift** - Main app entry point with window configuration
- **ContentView.swift** - Root view that displays KeyboardCleaner

### Main Components
- **KeyboardCleaner.swift** - Main cleaning interface with state management
- **CleaningTimer.swift** - Timer component that tracks cleaning duration
- **CleanButton.swift** - Start/Stop cleaning button with hover effects
- **KeyboardIcon.swift** - Keyboard illustration with animations and sparkles
- **ToastView.swift** - Toast notification component

### Supporting Files
- **ColorExtensions.swift** - Color definitions matching the original design
- **KeyboardKaddy.entitlements** - App entitlements for sandboxing

## Conversion Notes

### React → SwiftUI Conversions
- `useState` → `@State`
- `useEffect` → `.onAppear`, `.onChange`, `.onDisappear`
- `useCallback` → Regular Swift functions
- JSX → SwiftUI ViewBuilder syntax
- CSS classes → SwiftUI modifiers
- Event handlers → Swift closures

### Key Features Preserved
✅ All UI components and layouts
✅ Color scheme (coral primary, teal accent, cream background)
✅ Animations (wiggle, sparkle, hover effects)
✅ Timer functionality
✅ Toast notifications
✅ Keyboard event monitoring (ESC key handling)
✅ Rotating tips and messages

### macOS-Specific Considerations
- Uses `NSEvent` for keyboard monitoring
- May require Accessibility permissions for full keyboard blocking
- SwiftUI native animations instead of CSS
- Native macOS window styling

## Building the Project

See SETUP.md for detailed instructions on setting up the project in Xcode.

