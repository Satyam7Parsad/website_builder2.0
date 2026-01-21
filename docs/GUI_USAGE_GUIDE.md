# ImGui Website Builder - User Guide

## 🎯 Quick Start: Loading the Stripe Template

### Step 1: Find the Application Window

The application is **already running**. Look for a window that looks like this:

```
┌──────────────────────────────────────────────────────────────────────────┐
│ ● ○ ○  ImGui Website Designer                                             │
├──────────────────────────────────────────────────────────────────────────┤
│ File  Edit  View  Tools  Help                                             │
├────────────────────┬─────────────────────────────────┬────────────────────┤
│                    │                                 │                    │
│   LEFT PANEL       │      CENTER PANEL               │   RIGHT PANEL      │
│   Templates &      │      Preview Area               │   Properties       │
│   Sections List    │                                 │                    │
│                    │                                 │                    │
```

**Can't find it?** Press `Cmd + Tab` to cycle through open applications.

---

## Step 2: Locate the Templates Dropdown

On the **LEFT side** of the window, near the top, you'll see:

```
┌──────────────────────────────────────────┐
│  📁 Templates                            │
│                                          │
│  Current Template:                       │
│  ┌────────────────────────────────┐     │
│  │ Select a template...        ▼  │ ← CLICK HERE!
│  └────────────────────────────────┘     │
│                                          │
│  Or:                                     │
│  ┌────────────────────┐                 │
│  │  Load Template     │ ← OR CLICK HERE!
│  └────────────────────┘                 │
└──────────────────────────────────────────┘
```

---

## Step 3: Select "stripe_flexbox_test"

When you click the dropdown, you'll see a list like this:

```
┌──────────────────────────────────────────┐
│  imported_nike_com_1768065574            │
│  ▶ stripe_flexbox_test          (27) ← CLICK THIS ONE!
│  imported_nike_com_1768064495            │
│  imported_nike_com_1768064332            │
│  Imported Burgerking In 1768043347       │
│  imported_burgerking_in_1768043347       │
│  imported_online_kfc_co_in_1768043028    │
│  ...                                     │
└──────────────────────────────────────────┘
```

**Look for:** `stripe_flexbox_test` (shows 27 sections)

---

## Step 4: Template Loads Successfully

After clicking, you'll see at the bottom of the window:

```
✅ Loading template sections from database...
✅ Loaded 27 sections for template: stripe_flexbox_test
```

---

## Step 5: View the Sections List

The LEFT panel will now show all 27 sections:

```
┌──────────────────────────────────────────┐
│  📂 Sections (27)                        │
│  ─────────────────────────────────       │
│  ○ Section 0  - text-stack               │
│  ○ Section 1  - text-stack               │
│  ○ Section 2  - custom-stack             │
│  ○ Section 3  - text-stack               │
│  ○ Section 4  - custom-stack             │
│  ○ Section 5  - cards-4-grid-3col  ⭐    │ ← GRID LAYOUT!
│  ○ Section 6  - cards-4-grid-3col  ⭐    │ ← GRID LAYOUT!
│  ○ Section 7  - custom-stack             │
│  ...                                     │
│  ○ Section 20 - text-stack (Carousel)🎠  │ ← CAROUSEL!
│  ○ Section 21 - image-stack              │
│  ○ Section 22 - text-grid-3col     ⭐    │ ← GRID LAYOUT!
│  ○ Section 23 - text-stack               │
│  ...                                     │
└──────────────────────────────────────────┘
```

---

## Step 6: Click on a Section to See Details

**Try clicking Section 5** (it has grid layout):

The **RIGHT panel** will show:

```
┌──────────────────────────────────────────┐
│  ⚙️ Section Properties                   │
│  ─────────────────────────────────       │
│  Type: 4 (SEC_CARDS)                     │
│  Name: [section title]                   │
│  Height: 400px                           │
│  Width: 100%                             │
│                                          │
│  📐 Layout Settings:                     │
│  Position: 0, 0                          │
│  Padding: 60px                           │
│  Cards per row: 3                        │
│                                          │
│  🎨 Colors:                              │
│  Background: rgb(...)                    │
│  Text: rgb(...)                          │
│                                          │
│  💾 Enhanced Data (in DB):               │
│  - Type Name: "cards-4-grid-3col"        │
│  - Layout Mode: GRID                     │
│  - Grid Columns: "276px"                 │
└──────────────────────────────────────────┘
```

---

## Step 7: View the Preview

In the **CENTER panel**, you'll see:

- A visual preview of all 27 sections stacked vertically
- Scroll up/down to see different sections
- The selected section (Section 5) will be highlighted

---

## 🔍 How to Verify Enhancements are Working

### Check the Database (Terminal)

Open a new terminal and run:

```bash
cd /Users/imaging/Desktop/Website-Builder-v2.0

# See all custom types
psql -d website_builder -c "
SELECT type_name, COUNT(*)
FROM sections
WHERE template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND use_legacy_type = FALSE
GROUP BY type_name;"
```

**Expected Output:**
```
     type_name     | count
-------------------+-------
 custom-stack      |    14
 text-stack        |     9
 cards-4-grid-3col |     2  ← Grid sections!
 image-stack       |     1
 text-grid-3col    |     1  ← Grid section!
```

### Check Grid Layouts

```bash
psql -d website_builder -c "
SELECT s.section_order, s.type_name,
       l.grid_template_columns
FROM sections s
JOIN section_layout_properties l ON s.id = l.section_id
WHERE s.template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND l.layout_mode = 2
ORDER BY s.section_order;"
```

**Expected Output:**
```
 section_order |     type_name     | grid_template_columns
---------------+-------------------+----------------------
             5 | cards-4-grid-3col | 276px
             6 | cards-4-grid-3col | 276px
            22 | text-grid-3col    | 186px 186px
```

### Check Carousels

```bash
psql -d website_builder -c "
SELECT s.section_order,
       jsonb_array_length(i.carousel_images::jsonb) as image_count
FROM sections s
JOIN interactive_elements i ON s.id = i.section_id
WHERE s.template_id = (SELECT id FROM templates WHERE template_name = 'stripe_flexbox_test')
  AND i.element_type = 2;"
```

**Expected Output:**
```
 section_order | image_count
---------------+-------------
             3 |           0
            20 |           8  ← 8 carousel images!
```

---

## 📋 Available Templates

You can also try these templates:

| Template Name | Sections | Notable Features |
|--------------|----------|------------------|
| **stripe_flexbox_test** | 27 | ⭐ 3 grid layouts, 2 carousels, 5 custom types |
| imported_nike_com_1768065574 | 10 | 2 carousels, stack layouts |
| imported_nike_com_1768064332 | 10 | 2 carousels, stack layouts |
| imported_burgerking_in | 15 | Mixed layouts |
| imported_nescafe_com | 11 | Mixed layouts |

---

## 🎨 What Each Panel Shows

### LEFT Panel:
- Templates dropdown
- List of all sections (27 for Stripe)
- Click to select a section

### CENTER Panel:
- Visual preview of sections
- Scroll to see all sections
- Selected section is highlighted
- Shows layout with images, text, colors

### RIGHT Panel:
- Properties of selected section
- Type, dimensions, colors
- Typography settings
- Layout settings

---

## ⚡ Keyboard Shortcuts

- `Cmd + Tab` - Switch to builder window
- `Cmd + Q` - Quit application
- Mouse scroll - Scroll through preview
- Click - Select section

---

## ✅ What You Should See for Enhancements

When you load **stripe_flexbox_test**, the enhancements are **working** if you see:

1. ✅ **27 sections** load (not just 10-15)
2. ✅ Section names show **custom types** like "cards-4-grid-3col"
3. ✅ Database queries return **grid layout data**
4. ✅ Database queries return **carousel images** (8 images in section 20)
5. ✅ **5 different custom types** instead of forcing into generic types

---

## 🚀 Next Steps

Once you see the template loaded:

1. **Click through different sections** to see their properties
2. **Try Section 5, 6, or 22** - these have grid layouts stored in DB
3. **Try Section 20** - has carousel with 8 images
4. **Run the database queries** above to see the enhanced data

The enhancements are **working in the database** - the next phase would be adding rendering code to visualize the grid layouts and carousels in the preview window.

---

## ❓ Troubleshooting

**Don't see the window?**
- Press `Cmd + Tab` repeatedly to find it
- Check if process is running: `ps aux | grep imgui_website_designer`

**Template not loading?**
- Check database connection: `psql -d website_builder -c "SELECT COUNT(*) FROM templates;"`
- Restart: Kill process and run `./imgui_website_designer` again

**Need to restart?**
```bash
# Kill current instance
pkill imgui_website_designer

# Launch again
cd /Users/imaging/Desktop/Website-Builder-v2.0
./imgui_website_designer &
```

---

**The builder is ready to use - just follow the steps above!** 🎉
