# App Icon Setup Instructions

The app icon SVG has been added to the project. To complete the setup:

## Option 1: Using Online Converter (Easiest)

1. Go to https://cloudconvert.com/svg-to-png or similar service
2. Upload `KeyboardKaddy/sudocleaner-logo.svg`
3. Set output size to 1024x1024 pixels
4. Download the PNG
5. Use an image editor or online tool to create these sizes:
   - 16x16
   - 32x32
   - 64x64
   - 128x128
   - 256x256
   - 512x512
   - 1024x1024

6. Save them in `KeyboardKaddy/Assets.xcassets/AppIcon.appiconset/` with these names:
   - icon_16x16.png
   - icon_32x32.png
   - icon_64x64.png
   - icon_128x128.png
   - icon_256x256.png
   - icon_512x512.png
   - icon_1024x1024.png

## Option 2: Using macOS Preview

1. Open `sudocleaner-logo.svg` in Preview
2. File > Export
3. Choose PNG format
4. Export at each required size
5. Save to the AppIcon.appiconset folder

## Option 3: Using Xcode

1. Open the project in Xcode
2. Open `Assets.xcassets`
3. Select `AppIcon`
4. Drag and drop the SVG or PNG files into the appropriate slots
5. Xcode will automatically handle the sizing

After adding the icons, rebuild the project and the app icon will appear in the Dock and Finder.

