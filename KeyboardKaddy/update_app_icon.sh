#!/bin/bash

# Script to update app icon from a source image
# Usage: ./update_app_icon.sh /path/to/your/icon.png

if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_icon_image>"
    echo "Example: $0 ~/Desktop/app-icon.png"
    exit 1
fi

SOURCE_IMAGE="$1"
ICON_DIR="Assets.xcassets/AppIcon.appiconset"

if [ ! -f "$SOURCE_IMAGE" ]; then
    echo "Error: Image file not found: $SOURCE_IMAGE"
    exit 1
fi

echo "Generating app icons from: $SOURCE_IMAGE"
echo "Output directory: $ICON_DIR"

# Create directory if it doesn't exist
mkdir -p "$ICON_DIR"

# Generate all required icon sizes
echo "Generating 16x16..."
sips -z 16 16 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_16x16.png" > /dev/null 2>&1

echo "Generating 32x32..."
sips -z 32 32 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_32x32.png" > /dev/null 2>&1

echo "Generating 64x64..."
sips -z 64 64 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_64x64.png" > /dev/null 2>&1

echo "Generating 128x128..."
sips -z 128 128 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_128x128.png" > /dev/null 2>&1

echo "Generating 256x256..."
sips -z 256 256 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_256x256.png" > /dev/null 2>&1

echo "Generating 512x512..."
sips -z 512 512 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_512x512.png" > /dev/null 2>&1

echo "Generating 1024x1024..."
sips -z 1024 1024 "$SOURCE_IMAGE" --out "$ICON_DIR/icon_1024x1024.png" > /dev/null 2>&1

echo ""
echo "✅ All app icons generated successfully!"
echo "Rebuild the project in Xcode to see the new icon."

