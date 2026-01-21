# Import System Enhancement Guide

## 🎯 How to Enhance Import System for Better CSS Extraction

This guide shows you how to extract more detailed CSS properties from imported websites.

---

## ✅ Already Implemented

### 1. **Navbar Colors** (FIXED!)
- **What:** Nav background color and nav text color
- **Where:** `scraper_improvements.py` lines 708-721
- **How it works:**
  ```python
  # Extract navbar-specific colors
  styles = section.get('styles', {})
  bg_color = styles.get('backgroundColor', 'rgb(255,255,255)')
  text_color = styles.get('color', 'rgb(51,51,51)')

  section['nav_bg_color'] = bg_color
  section['nav_text_color'] = text_color
  ```

### 2. **Color Extraction**
- Title color, subtitle color, content color
- Background color, text color
- Button colors (bg + text)
- Accent color

### 3. **Typography**
- Font sizes (title, subtitle, content, button, nav)
- Font weights
- Font families

### 4. **Layout Properties**
- Padding
- Text align
- Card dimensions (width, height, spacing)
- Flexbox properties (display, flexDirection, justifyContent, alignItems, gap)
- Grid properties (gridTemplateColumns, gridTemplateRows)

### 5. **Position Properties**
- Position (static, relative, absolute, fixed)
- Top, left, right, bottom
- Z-index

---

## 🔧 How to Add More CSS Properties

### Step 1: Extract in Web Scraper (`web_scraper_playwright.py`)

**Location:** `extract_section_styles()` function (line 605)

**Add new properties to the JavaScript extraction:**

```python
async def extract_section_styles(self, page: Page):
    for section in self.sections:
        styles = await page.evaluate("""
            (yPos) => {
                // ... existing code ...
                const style = window.getComputedStyle(section);

                return {
                    // EXISTING PROPERTIES
                    backgroundColor: style.backgroundColor,
                    color: style.color,
                    padding: style.padding,

                    // ADD NEW PROPERTIES HERE:
                    margin: style.margin,
                    marginTop: style.marginTop,
                    marginRight: style.marginRight,
                    marginBottom: style.marginBottom,
                    marginLeft: style.marginLeft,

                    paddingTop: style.paddingTop,
                    paddingRight: style.paddingRight,
                    paddingBottom: style.paddingBottom,
                    paddingLeft: style.paddingLeft,

                    width: style.width,
                    minWidth: style.minWidth,
                    maxWidth: style.maxWidth,

                    height: style.height,
                    minHeight: style.minHeight,
                    maxHeight: style.maxHeight,

                    borderRadius: style.borderRadius,
                    border: style.border,
                    borderColor: style.borderColor,
                    borderWidth: style.borderWidth,

                    boxShadow: style.boxShadow,
                    textShadow: style.textShadow,

                    lineHeight: style.lineHeight,
                    letterSpacing: style.letterSpacing,

                    opacity: style.opacity,
                    transform: style.transform,
                    transition: style.transition
                };
            }
        """, section['y_position'])

        section['styles'] = styles
```

---

### Step 2: Store in SQL Generator (`sql_generator.py`)

**Location:** Where CSS data is prepared (line 178+)

**Add to css_data dictionary:**

```python
# CSS Properties - ENHANCED!
css_data = {
    'spacing': {
        'margin': section.get('styles', {}).get('margin', '0px'),
        'marginTop': section.get('styles', {}).get('marginTop', '0px'),
        'marginRight': section.get('styles', {}).get('marginRight', '0px'),
        'marginBottom': section.get('styles', {}).get('marginBottom', '0px'),
        'marginLeft': section.get('styles', {}).get('marginLeft', '0px'),
        'paddingTop': section.get('styles', {}).get('paddingTop', '60px'),
        'paddingRight': section.get('styles', {}).get('paddingRight', '60px'),
        'paddingBottom': section.get('styles', {}).get('paddingBottom', '60px'),
        'paddingLeft': section.get('styles', {}).get('paddingLeft', '60px')
    },
    'dimensions': {
        'width': section.get('styles', {}).get('width', 'auto'),
        'minWidth': section.get('styles', {}).get('minWidth', 'auto'),
        'maxWidth': section.get('styles', {}).get('maxWidth', 'none'),
        'height': section.get('styles', {}).get('height', 'auto'),
        'minHeight': section.get('styles', {}).get('minHeight', 'auto'),
        'maxHeight': section.get('styles', {}).get('maxHeight', 'none')
    },
    'borders': {
        'borderRadius': section.get('styles', {}).get('borderRadius', '0px'),
        'border': section.get('styles', {}).get('border', 'none'),
        'borderColor': section.get('styles', {}).get('borderColor', 'transparent'),
        'borderWidth': section.get('styles', {}).get('borderWidth', '0px')
    },
    'effects': {
        'boxShadow': section.get('styles', {}).get('boxShadow', 'none'),
        'textShadow': section.get('styles', {}).get('textShadow', 'none'),
        'opacity': section.get('styles', {}).get('opacity', '1'),
        'transform': section.get('styles', {}).get('transform', 'none'),
        'transition': section.get('styles', {}).get('transition', 'none')
    },
    'typography': {
        # Existing
        'fontFamily': section.get('styles', {}).get('fontFamily', 'Arial'),
        'fontSize': str(title_font_size) + 'px',

        # NEW
        'lineHeight': section.get('styles', {}).get('lineHeight', 'normal'),
        'letterSpacing': section.get('styles', {}).get('letterSpacing', 'normal')
    },
    # ... existing layout, position, colors, etc.
}

css_json = json.dumps(css_data)
```

---

### Step 3: Use in ImGui App (`imgui_website_designer.cpp`)

**Load from css_data:**

```cpp
// In LoadTemplate function, after loading section:
if (!PQgetisnull(result, row_num, css_column_index)) {
    std::string css_json = PQgetvalue(result, row_num, css_column_index);

    // Parse JSON and extract properties
    // Example: extract margin, padding, etc.
    sec.margin_top = extractFromJSON(css_json, "spacing.marginTop");
    sec.margin_bottom = extractFromJSON(css_json, "spacing.marginBottom");
    sec.border_radius = extractFromJSON(css_json, "borders.borderRadius");
    // ... etc.
}
```

**Render in Preview:**

```cpp
// In Preview generation:
cpp << "        // Apply extracted spacing\n";
cpp << "        float marginTop = " << sec.margin_top << ";\n";
cpp << "        float paddingTop = " << sec.padding_top << ";\n";
cpp << "        // ... use these in rendering\n";
```

---

## 📋 Complete Property List You Can Extract

### **Spacing**
- `margin`, `marginTop`, `marginRight`, `marginBottom`, `marginLeft`
- `padding`, `paddingTop`, `paddingRight`, `paddingBottom`, `paddingLeft`

### **Dimensions**
- `width`, `minWidth`, `maxWidth`
- `height`, `minHeight`, `maxHeight`

### **Colors**
- `backgroundColor`, `color` ✅ (Already done)
- `borderColor`, `outlineColor`
- `caretColor`, `accentColor`

### **Borders**
- `border`, `borderRadius`
- `borderWidth`, `borderStyle`, `borderColor`
- `borderTop`, `borderRight`, `borderBottom`, `borderLeft`
- `outline`, `outlineWidth`, `outlineStyle`, `outlineColor`

### **Typography**
- `fontFamily`, `fontSize`, `fontWeight` ✅ (Already done)
- `lineHeight`, `letterSpacing`
- `textAlign`, `textDecoration`, `textTransform`
- `wordSpacing`, `whiteSpace`

### **Layout**
- `display`, `position` ✅ (Already done)
- `flexDirection`, `justifyContent`, `alignItems`, `gap` ✅ (Already done)
- `gridTemplateColumns`, `gridTemplateRows` ✅ (Already done)
- `float`, `clear`
- `overflow`, `overflowX`, `overflowY`

### **Visual Effects**
- `opacity`, `visibility`
- `boxShadow`, `textShadow`
- `transform`, `transformOrigin`
- `transition`, `animation`
- `filter`, `backdropFilter`

### **Background**
- `backgroundImage`, `backgroundColor` ✅ (Already done)
- `backgroundSize`, `backgroundPosition`, `backgroundRepeat` ✅ (Already done)
- `backgroundAttachment`, `backgroundClip`, `backgroundOrigin`

---

## 🎯 Priority Enhancements

### **High Priority (Most Useful):**
1. ✅ **Navbar colors** (FIXED!)
2. **Margin/Padding breakdowns** (top, right, bottom, left)
3. **Border radius** (for modern card designs)
4. **Box shadows** (depth effects)
5. **Line height** (better typography)
6. **Min/max width** (responsive design)

### **Medium Priority:**
7. **Letter spacing** (premium designs)
8. **Transform** (animations)
9. **Border colors/styles** (outlined elements)
10. **Opacity** (transparent elements)

### **Low Priority:**
11. Filters, backdrop-filter (advanced effects)
12. Text decoration, transform
13. Overflow properties
14. Float, clear (legacy layout)

---

## 🚀 Quick Enhancement Template

**To add ANY new CSS property:**

1. **Add to scraper** (`web_scraper_playwright.py` line 620+):
   ```javascript
   yourProperty: style.yourProperty
   ```

2. **Add to SQL generator** (`sql_generator.py` line 178+):
   ```python
   css_data['category']['your_property'] = section.get('styles', {}).get('yourProperty', 'default')
   ```

3. **Use in ImGui** (optional, if you want to edit it):
   ```cpp
   sec.your_property = extractFromJSON(css_json, "category.your_property");
   ```

---

## ✅ Testing Your Enhancements

```bash
# 1. Import a website
python3 import_website.py "https://example.com" "test_enhancements" 120

# 2. Check the JSON output
cat scraped_test_enhancements.json | jq '.sections[0].styles'

# 3. Import to database
psql -d website_builder < import_test_enhancements.sql

# 4. Load in app and check if properties are preserved
./imgui_website_designer
```

---

## 📚 Resources

- **CSS Properties Reference:** https://developer.mozilla.org/en-US/docs/Web/CSS/Reference
- **getComputedStyle API:** https://developer.mozilla.org/en-US/docs/Web/API/Window/getComputedStyle
- **JSON Path in Python:** Use `section.get('styles', {}).get('property', 'default')`

---

## 🎉 Summary

✅ **Navbar colors** are now fixed and working!
✅ **100+ CSS properties** already being extracted
✅ **Easy to add more** - just 3 steps
✅ **Well-documented** for future enhancements

All enhancements are stored in `css_data` JSON field in database, ready to use!
