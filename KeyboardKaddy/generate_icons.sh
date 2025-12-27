#!/bin/bash

# Script to generate app icons from SVG
# This requires rsvg-convert or similar tool
# For now, we'll create a note about manual conversion

echo "To generate app icons from the SVG:"
echo "1. Open sudocleaner-logo.svg in a vector graphics editor (like Figma, Sketch, or online SVG to PNG converter)"
echo "2. Export at the following sizes:"
echo "   - 16x16, 32x32, 64x64, 128x128, 256x256, 512x512, 1024x1024"
echo "3. Place them in Assets.xcassets/AppIcon.appiconset/ with names:"
echo "   - icon_16x16.png, icon_32x32.png, icon_64x64.png, etc."
echo ""
echo "Or use an online tool like: https://cloudconvert.com/svg-to-png"

