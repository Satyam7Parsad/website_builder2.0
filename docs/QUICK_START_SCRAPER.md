# 🚀 Quick Start Guide - Website Scraper

**Import any website design in 3 easy steps!**

---

## Step 1: Install Dependencies (One-time Setup)

```bash
# Navigate to project directory
cd /Users/imaging/Desktop/Website-Builder-v2.0

# Install Python packages
pip3 install -r requirements.txt

# Install ChromeDriver (for Selenium)
brew install --cask chromedriver

# Verify installation
python3 -c "import selenium; import bs4; print('✅ Dependencies OK!')"
```

**Expected output:**
```
✅ Dependencies OK!
```

---

## Step 2: Import a Website

### Example 1: Simple Import

```bash
# Import example.com
python3 import_website.py https://example.com
```

### Example 2: With Custom Name

```bash
# Import with specific template name
python3 import_website.py https://www.pilatesstudio.com pilates_pro
```

### What Happens:
1. 🌐 Opens website in headless Chrome
2. 📸 Takes screenshot
3. 🔍 Detects sections automatically
4. 🎨 Extracts colors, fonts, spacing
5. 📥 Downloads all images
6. 📝 Generates PostgreSQL SQL script

**Output:**
```
╔══════════════════════════════════════════════════════════╗
║      Website Template Importer - Hybrid Approach         ║
╚══════════════════════════════════════════════════════════╝

🌐 Scraping website: https://example.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣  Loading page with Selenium...
   ✅ Chrome WebDriver initialized

2️⃣  Capturing full-page screenshot...
   📸 Screenshot saved: scraped_images/example_com/full_page.png

3️⃣  Extracting HTML content...

4️⃣  Detecting sections with computer vision...
   🔍 Analyzing page structure...
   📦 Found 12 potential sections
   ✅ Detected 8 valid sections

5️⃣  Extracting computed styles...

6️⃣  Extracting content...

7️⃣  Downloading images...
   📥 Downloaded: bg_0.jpg
   📥 Downloaded: img_2.png

8️⃣  Generating template data...

✅ Scraping completed successfully!
📊 Found 8 sections

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ SQL script generated: import_example_com.sql

╔══════════════════════════════════════════════════════════╗
║                    IMPORT COMPLETE!                       ║
╚══════════════════════════════════════════════════════════╝

📊 Summary:
   • Template: example_com
   • Sections: 8
   • Source: https://example.com

📁 Generated Files:
   • JSON Data:     scraped_example_com.json
   • SQL Script:    import_example_com.sql
   • Images:        scraped_images/example_com/

🚀 Next Steps:
   1. Review the generated SQL file
   2. Import to PostgreSQL:
      $ psql -d website_builder < import_example_com.sql
   3. Launch Website Builder to see the template!
```

---

## Step 3: Import to Database

```bash
# Import the template to PostgreSQL
psql -d website_builder < import_example_com.sql

# Verify import
psql -d website_builder -c "SELECT template_name, description FROM templates ORDER BY id DESC LIMIT 1;"
```

**Expected output:**
```
 template_name |           description
---------------+----------------------------------
 example_com   | Imported from example.com
(1 row)
```

---

## Step 4: View in Website Builder

```bash
# Launch the Website Builder
./launch.sh

# Your imported template will appear in the templates list!
```

**In the GUI:**
1. Click "Templates" button
2. Find your imported template (e.g., "example_com")
3. Click to load it
4. Edit and customize as needed!

---

## 🎯 Try These Examples

### Example Sites to Import:

```bash
# Modern portfolio
python3 import_website.py https://www.briannajacobsen.com portfolio_modern

# Business landing page
python3 import_website.py https://www.stripe.com/en-ca stripe_landing

# Simple blog
python3 import_website.py https://blog.google simple_blog

# E-commerce product page
python3 import_website.py https://www.apple.com/macbook-air macbook_template
```

---

## ⚡ Pro Tips

### 1. **Review Before Import**

```bash
# Scrape first, review JSON, then generate SQL
python3 web_scraper.py https://example.com test

# Review scraped_test.json - edit if needed

# Generate SQL after review
python3 sql_generator.py scraped_test.json
```

### 2. **Batch Import Multiple Pages**

```bash
# Create a script
cat > import_batch.sh << 'EOF'
#!/bin/bash
python3 import_website.py https://site1.com template1
python3 import_website.py https://site2.com template2
python3 import_website.py https://site3.com template3
EOF

chmod +x import_batch.sh
./import_batch.sh
```

### 3. **Extract Specific Section Types**

Edit `web_scraper.py` to filter:
```python
# Only hero and footer sections
if section_type not in [0, 10]:  # 0=Hero, 10=Footer
    continue
```

---

## 🔧 Troubleshooting

### Issue: "ChromeDriver not found"

```bash
# Install ChromeDriver
brew install --cask chromedriver

# If permission error:
xattr -d com.apple.quarantine /usr/local/bin/chromedriver
```

### Issue: "Module not found"

```bash
# Reinstall dependencies
pip3 install --upgrade -r requirements.txt
```

### Issue: "Connection refused"

```bash
# Check if website is accessible
curl -I https://example.com

# Try with different user-agent (edit web_scraper.py line 51)
```

### Issue: "No sections detected"

- Site might use iframes (not supported yet)
- Try increasing wait time: `time.sleep(5)` in scrape_website()
- Check scraped_template.json for raw data

---

## 📖 Full Documentation

For complete documentation, see:
- **WEB_SCRAPER_README.md** - Full feature documentation
- **Web scraper code** - `web_scraper.py` (well-commented)
- **SQL generator code** - `sql_generator.py` (well-commented)

---

## ✅ Checklist

Before running scraper:
- [ ] Python 3.8+ installed (`python3 --version`)
- [ ] Dependencies installed (`pip3 install -r requirements.txt`)
- [ ] ChromeDriver installed (`chromedriver --version`)
- [ ] PostgreSQL running (`brew services list | grep postgresql`)
- [ ] Website Builder database exists (`psql -d website_builder -c "\dt"`)

---

## 🎉 Success!

You now have a powerful web scraping system that can import any website design into your Website Builder!

**What you can do:**
- ✅ Import designs from Wix, Squarespace, WordPress
- ✅ Learn from professional website layouts
- ✅ Quickly prototype with real-world designs
- ✅ Build a library of templates

**Next level:**
- Customize section detection logic
- Add support for new section types
- Integrate with your favorite design sources
- Share templates with others

---

**Happy Scraping! 🚀**
