#!/bin/bash
# Setup Playwright for Advanced Website Scraping

echo "╔════════════════════════════════════════════════╗"
echo "║   Setting up Playwright for Website Import    ║"
echo "╚════════════════════════════════════════════════╝"
echo ""

# Step 1: Install Python dependencies
echo "📦 Step 1: Installing Python packages..."
pip3 install -r requirements_playwright.txt

if [ $? -ne 0 ]; then
    echo "❌ Failed to install Python packages"
    exit 1
fi

echo "✅ Python packages installed"
echo ""

# Step 2: Install Playwright browsers
echo "🌐 Step 2: Installing Playwright browsers..."
echo "   This will download Chromium (~170MB)..."
python3 -m playwright install chromium

if [ $? -ne 0 ]; then
    echo "❌ Failed to install Playwright browsers"
    exit 1
fi

echo "✅ Playwright browsers installed"
echo ""

# Step 3: Test installation
echo "🧪 Step 3: Testing Playwright installation..."
python3 -c "from playwright.sync_api import sync_playwright; print('✅ Playwright is working!')"

if [ $? -ne 0 ]; then
    echo "❌ Playwright test failed"
    exit 1
fi

echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║         ✅ Setup Complete!                     ║"
echo "╚════════════════════════════════════════════════╝"
echo ""
echo "Usage:"
echo "  python3 import_website_playwright.py <url> [template_name]"
echo ""
echo "Example:"
echo "  python3 import_website_playwright.py https://nike.com nike_template"
echo ""
