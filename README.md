# Website Builder v2.0

A powerful desktop application for creating and editing websites with a visual drag-and-drop interface, built with **ImGui** and **OpenGL**. Features include Figma-style layer editing, website importing, and PostgreSQL database integration.

## Features

### Core Features
- **Visual Website Designer** - Drag-and-drop interface for creating websites
- **Section-based Editing** - Hero, Navigation, Cards, Team, Pricing, Gallery, Contact, CTA, Footer sections
- **Real-time Preview** - Live preview in Chrome browser
- **Template System** - Save and load templates from PostgreSQL database
- **Export to C++ Code** - Generate standalone ImGui applications

### Figma-Style Import
- **URL Import** - Import any website design as editable layers
- **Layer-based Editing** - Edit text, images, buttons, and containers
- **Full-page Screenshots** - Automatic screenshot capture with Playwright
- **Position Preservation** - Maintains exact positions from original design

### Design Tools
- **Glass Morphism Effects** - Modern frosted glass UI elements
- **Animation System** - Fade, slide, zoom, and bounce animations
- **Color Customization** - Full control over all colors and styles
- **Font Management** - Custom font sizes and weights
- **Responsive Layouts** - Width and alignment controls

## Tech Stack

| Component | Technology |
|-----------|------------|
| GUI Framework | Dear ImGui |
| Graphics | OpenGL 3.3+ |
| Window Management | GLFW |
| Database | PostgreSQL |
| Web Scraping | Playwright (Python) |
| Image Loading | stb_image |
| Font | Inter (embedded) |

## Prerequisites

### macOS
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install glfw postgresql python3

# Install Python dependencies
pip3 install playwright
playwright install chromium
```

### Database Setup
```bash
# Start PostgreSQL
brew services start postgresql

# Create database
createdb website_builder

# The application will auto-create required tables on first run
```

## Installation

```bash
# Clone the repository
git clone ssh://git@hy1gitlab01.hyclon.com:2223/Satyam/webbuilder.git
cd webbuilder

# Build the application
./build.sh

# Launch the application
./launch.sh
```

## Project Structure

```
webbuilder/
├── imgui_website_designer.cpp   # Main application source
├── layout_engine.h              # Layout calculation engine
├── inter_font.h                 # Embedded Inter font
├── stb_image.h                  # Image loading library
├── imgui/                       # Dear ImGui library
│   ├── imgui.cpp
│   ├── imgui.h
│   ├── imgui_draw.cpp
│   ├── imgui_widgets.cpp
│   ├── imgui_impl_glfw.cpp
│   ├── imgui_impl_opengl3.cpp
│   └── ...
├── figma_layer_scraper.py       # Figma-style website importer
├── web_scraper_playwright.py    # Advanced web scraper
├── build.sh                     # Build script
├── launch.sh                    # Launch script
├── setup_playwright.sh          # Playwright setup script
└── templates/                   # Template storage
```

## Usage

### Creating a New Website
1. Launch the application with `./launch.sh`
2. Click section buttons (+Hero, +Navigation, etc.) to add sections
3. Select a section to edit its properties in the right panel
4. Use the Preview button to see your design in Chrome

### Importing from URL (Figma-Style)
1. Click **Import URL** button
2. Select **Figma-Style Import** tab
3. Enter the website URL
4. Click **Import as Figma Layers**
5. Edit layers using the Layers and Properties panels
6. Click **Save to DB** to save the template

### Saving Templates
1. Design your website
2. Click **Save Template**
3. Enter a name and description
4. Template is saved to PostgreSQL database

### Loading Templates
1. Click **Templates** button
2. Select a template from the gallery
3. Template loads with all sections and styles

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Scroll | Vertical scroll (canvas/Figma) |
| Shift + Scroll | Horizontal scroll |
| Ctrl + Scroll | Zoom in/out |
| Arrow Keys | Pan canvas (Figma mode) |
| Middle Mouse Drag | Pan canvas |

## Configuration

### Database Connection
Edit `launch.sh` or set environment variables:
```bash
export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=website_builder
export PGUSER=your_username
```

## API Reference

### Section Types
- `SEC_HERO` - Hero/Banner section
- `SEC_NAVBAR` - Navigation bar
- `SEC_CARDS` - Card grid layout
- `SEC_TEAM` - Team members section
- `SEC_PRICING` - Pricing tables
- `SEC_STATS` - Statistics display
- `SEC_GALLERY` - Image gallery
- `SEC_CONTACT` - Contact form
- `SEC_CTA` - Call to action
- `SEC_IMAGE` - Full-width image
- `SEC_TEXTBOX` - Text content block
- `SEC_FOOTER` - Footer section

### Layer Types (Figma Mode)
- `LAYER_DIV` - Container element
- `LAYER_TEXT` - Text element
- `LAYER_IMAGE` - Image element
- `LAYER_BUTTON` - Button element
- `LAYER_INPUT` - Input field

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Merge Request

## License

This project is proprietary software. All rights reserved.

## Author

**Satyam** - *Initial work and development*

## Acknowledgments

- [Dear ImGui](https://github.com/ocornut/imgui) - Immediate mode GUI library
- [GLFW](https://www.glfw.org/) - Window and input handling
- [Playwright](https://playwright.dev/) - Web scraping automation
- [stb_image](https://github.com/nothings/stb) - Image loading
- [Inter Font](https://rsms.me/inter/) - UI typeface
