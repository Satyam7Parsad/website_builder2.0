#!/bin/bash

# Website Builder v2.0 - Launch Script
# Quick launcher for the Website Designer application

APP_DIR="/Users/imaging/Desktop/Website-Builder-v2.0"
APP_NAME="imgui_website_designer"

echo "🚀 Launching Website Builder v2.0..."
echo ""

# Check if app exists
if [ ! -f "$APP_DIR/$APP_NAME" ]; then
    echo "❌ Error: Application not found!"
    echo "Building application..."
    cd "$APP_DIR" && ./build.sh

    if [ $? -ne 0 ]; then
        echo "❌ Build failed!"
        exit 1
    fi
fi

# Check if PostgreSQL is running
if ! pgrep -x "postgres" > /dev/null; then
    echo "⚠️  Warning: PostgreSQL is not running"
    echo "Starting PostgreSQL..."
    brew services start postgresql@14
    sleep 2
fi

# Launch the application
cd "$APP_DIR"
echo "✅ Launching application..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Website Builder v2.0 - With PostgreSQL Support"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

./"$APP_NAME"
