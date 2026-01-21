#!/bin/bash
echo "Testing URL Import System..."
echo "=============================="

# Test 1: Check Python and dependencies
echo ""
echo "1. Checking Python dependencies..."
python3 -c "
try:
    from selenium import webdriver
    from selenium.webdriver.chrome.service import Service
    from selenium.webdriver.chrome.options import Options
    from bs4 import BeautifulSoup
    import requests
    print('✓ All dependencies installed')
except ImportError as e:
    print(f'✗ Missing dependency: {e}')
    exit(1)
"

# Test 2: Check ChromeDriver
echo ""
echo "2. Checking ChromeDriver..."
python3 -c "
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
try:
    options = Options()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=options)
    driver.quit()
    print('✓ ChromeDriver works')
except Exception as e:
    print(f'✗ ChromeDriver error: {e}')
    exit(1)
"

# Test 3: Check database connection
echo ""
echo "3. Checking PostgreSQL connection..."
psql -d website_builder -c "SELECT 1;" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✓ PostgreSQL connected"
else
    echo "✗ PostgreSQL connection failed"
    exit 1
fi

# Test 4: Try a simple import
echo ""
echo "4. Testing import with example.com..."
python3 import_website.py "https://example.com" "test_import_$(date +%s)" 2>&1 | tail -20

echo ""
echo "=============================="
echo "If all tests pass, the import system is working!"
