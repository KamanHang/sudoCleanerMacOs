# Keyboard Kaddy - Swift Edition

A macOS app for helping you clean your keyboard by disabling keyboard input during cleaning sessions.

## Features

- 🧹 Start/stop cleaning mode with a single click
- ⏱️ Timer to track cleaning duration
- ⌨️ Keyboard input disabled during cleaning
- 🎯 Triple ESC to quickly exit cleaning mode
- 💡 Helpful cleaning tips that cycle during cleaning
- ✨ Beautiful animations and UI

## Requirements

- macOS 13.0 (Ventura) or later
- Xcode 14.0 or later

## Building the Project

1. Open the project in Xcode
2. Select your development team in the project settings
3. Build and run (⌘R)

## Usage

1. Click "Start Cleaning" to begin
2. Your keyboard input will be disabled
3. Clean your keyboard
4. Press ESC three times quickly to stop, or click "Stop Cleaning"

## Project Structure

- `KeyboardKaddyApp.swift` - Main app entry point
- `ContentView.swift` - Root view
- `KeyboardCleaner.swift` - Main cleaning interface
- `CleaningTimer.swift` - Timer component
- `CleanButton.swift` - Start/stop button
- `KeyboardIcon.swift` - Keyboard illustration
- `ToastView.swift` - Toast notifications
- `ColorExtensions.swift` - Color definitions matching original design

## Notes

- The app uses NSEvent monitoring to intercept keyboard events during cleaning mode
- Toast notifications appear at the top of the window
- The UI matches the original React/TypeScript version

