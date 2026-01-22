# Figma-Style Import Documentation

## Complete Guide for Website Builder v2.0

---

## Table of Contents

1. [Overview](#overview)
2. [System Requirements](#system-requirements)
3. [Installation & Setup](#installation--setup)
4. [How It Works](#how-it-works)
5. [Usage Guide](#usage-guide)
6. [Technical Architecture](#technical-architecture)
7. [Data Flow Diagram](#data-flow-diagram)
8. [File Structure](#file-structure)
9. [Database Schema](#database-schema)
10. [Troubleshooting](#troubleshooting)
11. [Replicating on Other Systems](#replicating-on-other-systems)

---

## Overview

The **Figma-Style Import** feature allows you to import any website as editable layers, similar to how Figma imports designs. This creates a pixel-perfect representation of the website with individual elements (text, images, buttons, containers) that can be edited, repositioned, and exported.

### Key Features

| Feature | Description |
|---------|-------------|
| **Full-Page Screenshot** | Captures entire page including off-screen content |
| **Layer Extraction** | Extracts every visible DOM element as a separate layer |
| **Image Download** | Downloads all images locally |
| **Style Preservation** | Preserves colors, fonts, borders, shadows |
| **Interactive Editing** | Edit any layer in the ImGui canvas |
| **Export to ImGui Code** | Generate standalone C++ application |
| **Save to Database** | Store templates in PostgreSQL |

---

## System Requirements

### Hardware
- macOS 10.14+ (or Linux/Windows with modifications)
- 4GB+ RAM
- GPU with OpenGL 3.3+ support

### Software Dependencies

| Component | Version | Purpose |
|-----------|---------|---------|
| **Python** | 3.8+ | Web scraping |
| **Playwright** | 1.40+ | Browser automation |
| **PostgreSQL** | 12+ | Template storage |
| **GLFW** | 3.3+ | Window management |
| **OpenGL** | 3.3+ | Graphics rendering |

---

## Installation & Setup

### Step 1: Install System Dependencies (macOS)

```bash
# Install Homebrew if not installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install glfw postgresql python3

# Start PostgreSQL
brew services start postgresql

# Create database
createdb website_builder
```

### Step 2: Setup Python Virtual Environment

```bash
cd /path/to/Website-Builder-v2.0

# Create virtual environment for Playwright
python3 -m venv playwright_env

# Activate it
source playwright_env/bin/activate

# Install required packages
pip install playwright playwright-stealth

# Install Chromium browser for Playwright
playwright install chromium

# Deactivate when done
deactivate
```

### Step 3: Verify Setup

```bash
# Test Playwright installation
source playwright_env/bin/activate
python3 -c "from playwright.async_api import async_playwright; print('Playwright OK')"
deactivate
```

### Step 4: Build the Application

```bash
./build.sh
```

### Step 5: Launch

```bash
./launch.sh
```

---

## How It Works

### High-Level Workflow

```
┌─────────────────┐
│   Website URL   │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  Python: figma_layer_scraper.py    │
│  (Playwright + Stealth)            │
│                                     │
│  1. Launch headless Chromium       │
│  2. Navigate to URL                │
│  3. Scroll entire page             │
│  4. Take full-page screenshot      │
│  5. Extract DOM elements as layers │
│  6. Download images                │
│  7. Export layers.json             │
└────────┬────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  /tmp/figma_import/                │
│  ├── screenshot.png                │
│  ├── layers.json                   │
│  └── images/                       │
│      ├── img_0.png                 │
│      ├── img_1.jpg                 │
│      └── ...                       │
└────────┬────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  C++: imgui_website_designer.cpp   │
│                                     │
│  1. Parse layers.json              │
│  2. Load screenshot as texture     │
│  3. Load layer images as textures  │
│  4. Populate g_FigmaProject        │
│  5. Enter Figma editing mode       │
└────────┬────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────┐
│  ImGui Figma Editor                │
│                                     │
│  • Canvas with all layers          │
│  • Layer panel (tree view)         │
│  • Properties panel                │
│  • Interactive editing             │
│  • Export / Save options           │
└─────────────────────────────────────┘
```

---

## Usage Guide

### Importing a Website

1. **Launch the application**
   ```bash
   ./launch.sh
   ```

2. **Click "Import URL" button** in the top toolbar

3. **Select "Figma-Style Import" tab**

4. **Enter the website URL** (e.g., `https://www.nike.com`)

5. **Click "Import as Figma Layers"**

6. **Wait for import** (typically 10-30 seconds depending on page size)

7. **View and edit** the imported layers in the canvas

### Editing Layers

| Action | How To |
|--------|--------|
| **Select layer** | Click on layer in canvas or layer panel |
| **Move layer** | Drag selected layer |
| **Resize layer** | Drag corner/edge handles |
| **Edit text** | Select text layer → Edit in Properties panel |
| **Change color** | Use color pickers in Properties panel |
| **Toggle visibility** | Click eye icon in Layers panel |
| **Lock layer** | Click lock icon in Properties panel |

### Saving Templates

1. Click **"Save to DB"** button
2. Enter template name
3. Template is saved to PostgreSQL with all layers and images

### Loading Templates

1. Click **"Templates"** button
2. Select a Figma-style template from gallery
3. Template loads with all layers intact

### Exporting to ImGui Code

1. Load a Figma template
2. Click **"Export Code"** button
3. Choose export location
4. Build the exported project:
   ```bash
   cd exported_folder/
   ./build.sh
   ./app_name
   ```

---

## Technical Architecture

### Layer Types

```cpp
enum LayerType {
    LAYER_DIV,      // Container/wrapper elements
    LAYER_TEXT,     // Text content (h1, h2, p, span, a)
    LAYER_IMAGE,    // Image elements
    LAYER_BUTTON,   // Buttons and clickable elements
    LAYER_INPUT,    // Form inputs
    LAYER_ICON,     // SVG icons
    LAYER_VIDEO,    // Video elements
    LAYER_SHAPE     // Decorative shapes
};
```

### WebLayer Structure

```cpp
struct WebLayer {
    // Identity
    int id;
    LayerType type;
    std::string name;

    // Position (absolute pixels)
    float x, y;
    float width, height;
    int z_index;

    // Content
    std::string text;
    std::string image_path;
    std::string href;
    GLuint texture_id;

    // Colors (RGBA 0.0-1.0)
    ImVec4 bg_color;
    ImVec4 text_color;
    ImVec4 border_color;

    // Typography
    float font_size;
    float font_weight;
    std::string font_family;
    int text_align;

    // Border & Shape
    float border_width;
    float border_radius;

    // Effects
    float opacity;
    std::string box_shadow;

    // State
    bool visible;
    bool locked;
    bool selected;
};
```

### FigmaProject Structure

```cpp
struct FigmaProject {
    std::string name;
    float canvas_width;
    float canvas_height;
    std::string screenshot_path;
    GLuint screenshot_texture_id;
    std::vector<WebLayer> layers;

    // Viewport
    float scroll_x, scroll_y;
    float zoom;

    // Selection
    std::vector<int> selected_layer_ids;
};
```

---

## Data Flow Diagram

```
USER INPUT
    │
    │ URL: "https://example.com"
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ C++ ImportFigmaLayers()                                           │
│ imgui_website_designer.cpp:4570                                   │
│                                                                   │
│ cmd = "cd /path && source playwright_env/bin/activate &&          │
│        python3 figma_layer_scraper.py <URL> /tmp/figma_import"   │
└───────────────────────────────────────────────────────────────────┘
    │
    │ popen() system call
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ Python figma_layer_scraper.py                                     │
│                                                                   │
│ async def extract_layers():                                       │
│     browser = await playwright.chromium.launch(headless=True)     │
│     page = await browser.new_page(viewport={1920, 1080})          │
│     await stealth.apply_stealth_async(page)                       │
│     await page.goto(url, wait_until='networkidle')                │
│     await scroll_full_page(page)                                  │
│     await page.screenshot(path='screenshot.png', full_page=True)  │
│     layers = await page.evaluate(js_extract_layers)               │
│     await download_images(layers)                                 │
│     save_json(layers)                                             │
└───────────────────────────────────────────────────────────────────┘
    │
    │ JavaScript DOM Extraction
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ JS: Extract All DOM Elements                                      │
│                                                                   │
│ function processElement(el, depth) {                              │
│     const rect = el.getBoundingClientRect();                      │
│     const style = getComputedStyle(el);                           │
│                                                                   │
│     layer = {                                                     │
│         type: classifyElement(el),                                │
│         x: rect.left + scrollX,                                   │
│         y: rect.top + scrollY,                                    │
│         width: rect.width,                                        │
│         height: rect.height,                                      │
│         bgColor: style.backgroundColor,                           │
│         textColor: style.color,                                   │
│         fontSize: style.fontSize,                                 │
│         borderRadius: style.borderRadius,                         │
│         ...                                                       │
│     };                                                            │
│                                                                   │
│     for (child of el.children) {                                  │
│         processElement(child, depth + 1);                         │
│     }                                                             │
│ }                                                                 │
└───────────────────────────────────────────────────────────────────┘
    │
    │ Output files
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ /tmp/figma_import/                                                │
│                                                                   │
│ screenshot.png     (1920 x N pixels, full page)                   │
│ layers.json        (all layer data)                               │
│ images/                                                           │
│   img_0.png                                                       │
│   img_1.jpg                                                       │
│   img_2.webp                                                      │
│   ...                                                             │
└───────────────────────────────────────────────────────────────────┘
    │
    │ C++ parses JSON
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ C++ Parse & Load                                                  │
│                                                                   │
│ // Read JSON file                                                 │
│ jsonContent = readFile("/tmp/figma_import/layers.json")           │
│                                                                   │
│ // Parse project metadata                                         │
│ g_FigmaProject.canvas_width = parseFloat("canvas_width")          │
│ g_FigmaProject.canvas_height = parseFloat("canvas_height")        │
│                                                                   │
│ // Load screenshot texture                                        │
│ data = stbi_load(screenshot_path)                                 │
│ glGenTextures(&g_FigmaProject.screenshot_texture_id)              │
│ glTexImage2D(data)                                                │
│                                                                   │
│ // Parse each layer                                               │
│ for each layer in layers:                                         │
│     WebLayer wl;                                                  │
│     wl.x = parseFloat("x")                                        │
│     wl.y = parseFloat("y")                                        │
│     wl.text = parseString("text")                                 │
│     wl.bg_color = parseColor("bg_color")                          │
│     if (wl.type == LAYER_IMAGE):                                  │
│         wl.texture_id = loadTexture(wl.image_path)                │
│     g_FigmaProject.layers.push_back(wl)                           │
│                                                                   │
│ g_FigmaMode = true                                                │
└───────────────────────────────────────────────────────────────────┘
    │
    │ Render in ImGui
    ▼
┌───────────────────────────────────────────────────────────────────┐
│ ImGui Figma Editor                                                │
│                                                                   │
│ ┌─────────────────────────────────────────────────────────────┐   │
│ │ [Templates] [New] [Import URL] [Save to DB] [Export Code]   │   │
│ ├─────────────┬───────────────────────────┬───────────────────┤   │
│ │ LAYERS      │     CANVAS                │  PROPERTIES       │   │
│ │             │                           │                   │   │
│ │ □ Header    │  ┌───────────────────┐    │  Name: [Header  ] │   │
│ │ □ Hero      │  │     Website       │    │  X: [0  ] Y: [0 ] │   │
│ │   □ Title   │  │     Preview       │    │  W: [1920] H:[80] │   │
│ │   □ Button  │  │                   │    │                   │   │
│ │ □ Content   │  │  (scrollable)     │    │  BG: [████] #FFF  │   │
│ │   □ Text 1  │  │                   │    │  Text: [████] #000│   │
│ │   □ Image 1 │  └───────────────────┘    │                   │   │
│ │ □ Footer    │                           │  Font Size: [16]  │   │
│ │             │                           │  Opacity: [1.0]   │   │
│ └─────────────┴───────────────────────────┴───────────────────┘   │
└───────────────────────────────────────────────────────────────────┘
```

---

## File Structure

```
Website-Builder-v2.0/
├── imgui_website_designer.cpp    # Main application (12000+ lines)
├── figma_layer_scraper.py        # Python web scraper
├── layout_engine.h               # Layout calculations
├── inter_font.h                  # Embedded font
├── stb_image.h                   # Image loading
├── build.sh                      # Build script
├── launch.sh                     # Launch script
├── setup_playwright.sh           # Playwright setup
│
├── playwright_env/               # Python virtual environment
│   ├── bin/
│   │   ├── activate              # Activation script
│   │   ├── python3
│   │   └── playwright
│   └── lib/
│       └── python3.x/
│           └── site-packages/
│               ├── playwright/
│               └── playwright_stealth/
│
├── imgui/                        # ImGui library
│   ├── imgui.cpp
│   ├── imgui.h
│   ├── imgui_draw.cpp
│   ├── imgui_widgets.cpp
│   ├── imgui_tables.cpp
│   └── backends/
│       ├── imgui_impl_glfw.cpp
│       ├── imgui_impl_glfw.h
│       ├── imgui_impl_opengl3.cpp
│       └── imgui_impl_opengl3.h
│
├── figma_templates/              # Saved Figma templates
│   ├── Nike/
│   │   ├── screenshot.png
│   │   └── images/
│   ├── Nescafe/
│   │   ├── screenshot.png
│   │   └── images/
│   └── ...
│
└── /tmp/figma_import/            # Temporary import folder
    ├── screenshot.png
    ├── layers.json
    └── images/
        ├── img_0.png
        ├── img_1.jpg
        └── ...
```

---

## Database Schema

### Templates Table

```sql
CREATE TABLE templates (
    id SERIAL PRIMARY KEY,
    template_name VARCHAR(100) UNIQUE NOT NULL,
    project_name VARCHAR(100),
    description TEXT,
    is_figma_template BOOLEAN DEFAULT FALSE,
    figma_screenshot_path TEXT,
    figma_screenshot_data BYTEA,
    figma_canvas_width INTEGER,
    figma_canvas_height INTEGER,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Figma Layers Table

```sql
CREATE TABLE figma_layers (
    id SERIAL PRIMARY KEY,
    template_id INTEGER REFERENCES templates(id) ON DELETE CASCADE,
    layer_order INTEGER DEFAULT 0,
    layer_type INTEGER NOT NULL,
    name VARCHAR(255),

    -- Position
    x REAL DEFAULT 0,
    y REAL DEFAULT 0,
    width REAL DEFAULT 100,
    height REAL DEFAULT 100,
    z_index INTEGER DEFAULT 0,

    -- Content
    text_content TEXT,
    image_path TEXT,
    image_data BYTEA,
    href TEXT,

    -- Colors (stored as "r,g,b,a")
    bg_color VARCHAR(50),
    text_color VARCHAR(50),
    border_color VARCHAR(50),

    -- Typography
    font_size REAL DEFAULT 16,
    font_weight INTEGER DEFAULT 400,
    font_family VARCHAR(100),
    text_align INTEGER DEFAULT 0,

    -- Border
    border_width REAL DEFAULT 0,
    border_radius REAL DEFAULT 0,

    -- Effects
    opacity REAL DEFAULT 1.0,
    box_shadow TEXT,

    -- State
    visible BOOLEAN DEFAULT TRUE,
    locked BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_figma_layers_template ON figma_layers(template_id);
CREATE INDEX idx_figma_layers_order ON figma_layers(layer_order);
```

---

## Troubleshooting

### Common Issues

#### 1. "Playwright not found"

```bash
# Solution: Reinstall playwright in virtual environment
cd /path/to/Website-Builder-v2.0
source playwright_env/bin/activate
pip install --upgrade playwright playwright-stealth
playwright install chromium
deactivate
```

#### 2. "ERR_CERT_COMMON_NAME_INVALID"

This occurs when the website has SSL certificate issues. The scraper can be modified to ignore SSL errors:

```python
# In figma_layer_scraper.py, add to browser launch:
browser = await p.chromium.launch(
    headless=True,
    args=['--ignore-certificate-errors']
)
```

#### 3. "Import takes too long"

- Some websites have heavy JavaScript that takes time to load
- The scraper waits for `networkidle` which can be slow
- Try reducing timeout or using `wait_until='load'` instead

#### 4. "Images not loading"

- Check if images are downloaded to `/tmp/figma_import/images/`
- Some images may be blocked by CORS or anti-hotlinking
- WebP images are supported

#### 5. "Export crashes"

- Ensure the exported folder has correct permissions
- Check if ImGui library files are copied correctly
- Verify OpenGL/GLFW installation

---

## Replicating on Other Systems

### Step-by-Step Setup for New System

#### 1. Clone Repository

```bash
git clone ssh://git@your-gitlab/Satyam/webbuilder.git
cd webbuilder
```

#### 2. Install macOS Dependencies

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Required packages
brew install glfw postgresql python3

# Start PostgreSQL
brew services start postgresql
createdb website_builder
```

#### 3. Setup Python Environment

```bash
# Create virtual environment
python3 -m venv playwright_env

# Activate
source playwright_env/bin/activate

# Install packages
pip install playwright playwright-stealth

# Install browser
playwright install chromium

# Deactivate
deactivate
```

#### 4. Build Application

```bash
./build.sh
```

#### 5. Configure Database (Optional)

Edit `launch.sh` to set database credentials:

```bash
export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=website_builder
export PGUSER=your_username
```

#### 6. Run

```bash
./launch.sh
```

### Linux Setup (Ubuntu/Debian)

```bash
# Install dependencies
sudo apt update
sudo apt install -y build-essential libglfw3-dev libgl1-mesa-dev postgresql python3-venv

# Start PostgreSQL
sudo systemctl start postgresql
sudo -u postgres createdb website_builder

# Setup Python
python3 -m venv playwright_env
source playwright_env/bin/activate
pip install playwright playwright-stealth
playwright install chromium
playwright install-deps
deactivate

# Build
./build.sh

# Run
./launch.sh
```

### Windows Setup (WSL2 Recommended)

Use Windows Subsystem for Linux (WSL2) with Ubuntu:

```bash
# In WSL2 Ubuntu terminal
# Follow Linux setup instructions above
```

---

## Python Scraper Details

### figma_layer_scraper.py Key Functions

```python
class FigmaLayerScraper:
    def __init__(self, url, output_dir):
        self.url = url
        self.output_dir = output_dir
        self.screenshot_path = f"{output_dir}/screenshot.png"
        self.layers = []
        self.canvas_width = 1920
        self.canvas_height = 0

    async def extract_layers(self):
        """Main extraction function"""
        async with async_playwright() as p:
            # 1. Launch browser
            browser = await p.chromium.launch(headless=True)
            context = await browser.new_context(
                viewport={'width': 1920, 'height': 1080}
            )
            page = await context.new_page()

            # 2. Apply stealth
            stealth = Stealth()
            await stealth.apply_stealth_async(page)

            # 3. Navigate
            await page.goto(self.url, wait_until='networkidle')

            # 4. Scroll to load lazy content
            await self._scroll_page(page)

            # 5. Screenshot
            await page.screenshot(
                path=self.screenshot_path,
                full_page=True
            )

            # 6. Extract layers via JavaScript
            self.layers = await page.evaluate(self._js_extract_layers())

            # 7. Download images
            await self._download_images(page)

            # 8. Save JSON
            self._save_output()

            await browser.close()

    def _js_extract_layers(self):
        """JavaScript to extract DOM elements"""
        return '''
        () => {
            const layers = [];
            const seenRects = new Set();

            function processElement(el, depth = 0) {
                if (depth > 20) return;

                const rect = el.getBoundingClientRect();
                const style = getComputedStyle(el);

                // Skip invisible/tiny
                if (style.display === 'none') return;
                if (rect.width < 5 || rect.height < 5) return;

                // Absolute position
                const x = rect.left + window.scrollX;
                const y = rect.top + window.scrollY;

                // Deduplicate
                const key = `${Math.round(x)},${Math.round(y)},${Math.round(rect.width)},${Math.round(rect.height)}`;
                if (seenRects.has(key)) return;
                seenRects.add(key);

                // Classify type
                const tag = el.tagName.toLowerCase();
                let type = 'div';
                let text = '';
                let imageSrc = '';

                if (['h1','h2','h3','h4','h5','h6','p','span','a','label'].includes(tag)) {
                    type = 'text';
                    text = el.textContent.trim().substring(0, 500);
                }
                if (tag === 'img') {
                    type = 'image';
                    imageSrc = el.src || el.dataset.src || '';
                }
                if (tag === 'button' || el.getAttribute('role') === 'button') {
                    type = 'button';
                    text = el.textContent.trim();
                }
                if (tag === 'input' || tag === 'textarea') {
                    type = 'input';
                    text = el.placeholder || '';
                }

                layers.push({
                    type: type,
                    x: Math.round(x),
                    y: Math.round(y),
                    width: Math.round(rect.width),
                    height: Math.round(rect.height),
                    z_index: parseInt(style.zIndex) || 0,
                    text: text,
                    image_path: imageSrc,
                    bg_color: style.backgroundColor,
                    text_color: style.color,
                    font_size: parseFloat(style.fontSize),
                    font_weight: parseInt(style.fontWeight),
                    border_radius: parseFloat(style.borderRadius) || 0,
                    opacity: parseFloat(style.opacity),
                    border_width: parseFloat(style.borderWidth) || 0,
                    border_color: style.borderColor
                });

                // Recurse children
                for (const child of el.children) {
                    processElement(child, depth + 1);
                }
            }

            processElement(document.body);

            // Sort by z-index, then y position
            layers.sort((a, b) => {
                if (a.z_index !== b.z_index) return a.z_index - b.z_index;
                return a.y - b.y;
            });

            return layers;
        }
        '''
```

---

## Export Code Structure

When you click "Export Code", the following is generated:

```
ProjectName_ImGui/
├── main.cpp              # Complete ImGui application
├── build.sh              # Build script
├── README.md             # Instructions
├── stb_image.h           # Image loading library
├── imgui/                # ImGui library
│   ├── imgui.cpp
│   ├── imgui.h
│   ├── imgui_draw.cpp
│   ├── imgui_widgets.cpp
│   ├── imgui_tables.cpp
│   ├── imgui_impl_glfw.cpp
│   ├── imgui_impl_glfw.h
│   ├── imgui_impl_opengl3.cpp
│   └── imgui_impl_opengl3.h
└── images/               # All layer images
    ├── screenshot.png
    ├── img_0.png
    ├── img_1.jpg
    └── ...
```

### Building Exported Code

```bash
cd ProjectName_ImGui/
./build.sh
./ProjectName
```

---

## Summary

The Figma-Style Import feature provides a powerful way to:

1. **Import any website** as editable layers
2. **Preserve visual fidelity** with full-page screenshots and precise positioning
3. **Edit individual elements** with a Figma-like interface
4. **Export to standalone ImGui** applications
5. **Save to database** for reuse

This workflow bridges web design and native C++ applications, allowing designers to use existing websites as templates for ImGui-based tools.

---

**Document Version:** 1.0
**Last Updated:** January 2026
**Author:** Website Builder v2.0 Team
