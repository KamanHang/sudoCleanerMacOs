# Setting Up the Swift Project

This SwiftUI project has been converted from the React/TypeScript version. To use it:

## Option 1: Create New Xcode Project (Recommended)

1. Open Xcode
2. Create a new project:
   - Choose "macOS" → "App"
   - Product Name: `KeyboardKaddy`
   - Interface: SwiftUI
   - Language: Swift
   - Uncheck "Use Core Data" and "Include Tests" if you want
3. Replace the generated files with the files from this folder:
   - Copy all `.swift` files from `KeyboardKaddy/` to your new project
   - Make sure to add them to the target
4. Build and run (⌘R)

## Option 2: Use the Provided Xcode Project

1. Open `KeyboardKaddy.xcodeproj` in Xcode
2. Select your development team in project settings
3. Build and run (⌘R)

## Important Notes

- **Keyboard Blocking**: For full keyboard input blocking, the app may need Accessibility permissions. macOS will prompt you to grant these permissions.
- **Minimum macOS Version**: macOS 13.0 (Ventura) or later
- **Xcode Version**: Xcode 14.0 or later recommended

## Features Preserved

✅ Same UI design and layout
✅ Cleaning timer
✅ Start/Stop cleaning button
✅ Keyboard icon with animations
✅ Toast notifications
✅ Triple ESC to exit
✅ Rotating cleaning tips
✅ All color schemes and styling

## Troubleshooting

If keyboard blocking doesn't work:
1. Go to System Settings → Privacy & Security → Accessibility
2. Add KeyboardKaddy to the list of allowed apps
3. Restart the app

