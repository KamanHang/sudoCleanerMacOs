# SudoCleaner 

A macOS app for helping you clean your keyboard by disabling keyboard input during cleaning sessions.

## Why I created this APP
- Frustration: Keys triggers while cleaning keyboard.
- Can't Disable Keyboard while cleaning.
- Locking Screen may be a good idea you think but random password attempt lead to disable of the Mac Account.
- Shutdown won't work as any key press triggers mac to boot itself.
- Yes APP Store has a lot of APPs but privacy concerns is priority as I have no idea what is running behid those apps. So I built it myself.
- I wanted to learn and build my First macOs App with Swift.

## Features

- 🧹 Start/stop cleaning mode with a single click
- ⌨️ Keyboard input disabled during cleaning
- ✨ Beautiful animations and UI
- ✨ Less Space

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
- Toast notifications appear at the bottom right of the window


