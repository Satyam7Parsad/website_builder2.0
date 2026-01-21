==========================================
   IMGUI WEBSITE BUILDER v2.0
==========================================

A professional website design tool built with ImGui.
Create stunning websites visually and export to WebAssembly!

==========================================
FEATURES
==========================================

✓ Drag & Drop Section Builder
  - Hero, About, Services, Features, Cards, Team, Pricing
  - Testimonials, Stats, Gallery, FAQ, Contact, CTA, Footer

✓ Template System
  - Save your designs as reusable templates
  - Load templates instantly
  - Templates stored in JSON format

✓ Live Preview
  - Preview websites in browser (WebAssembly)
  - Real-time rendering

✓ Export & Host
  - Export complete project with source code
  - Ready to deploy on any web server

==========================================
HOW TO RUN
==========================================

1. Double-click: imgui_website_designer
   OR
2. Terminal: ./imgui_website_designer

==========================================
HOW TO BUILD (if needed)
==========================================

1. Open Terminal
2. Navigate to this folder
3. Run: ./build.sh
4. Done!

==========================================
FOLDER STRUCTURE
==========================================

imgui_website_designer     - Main application (executable)
imgui_website_designer.cpp - Source code
build.sh                   - Build script
imgui/                     - ImGui library files
templates/                 - Your saved templates (JSON)
inter_font.h              - Embedded Inter font
Inter-Regular.ttf         - Inter font file
stb_image.h               - Image loading library

==========================================
USAGE
==========================================

1. CREATE DESIGN:
   - Add sections from left panel
   - Customize content, colors, fonts
   - Arrange sections in layers panel

2. SAVE TEMPLATE:
   - Click "Save Template" button
   - Enter name and description
   - Template saved to templates/ folder

3. LOAD TEMPLATE:
   - Click "Templates" button
   - Browse template gallery
   - Click template to load

4. PREVIEW:
   - Click "Preview" button
   - Browser opens with live preview
   - Test your website

5. EXPORT:
   - Click "Export" button
   - Choose export location
   - Get complete project files

==========================================
SYSTEM REQUIREMENTS
==========================================

- macOS (tested on macOS Ventura and later)
- Display with OpenGL support
- For WebAssembly export: Emscripten SDK

==========================================
VERSION HISTORY
==========================================

v2.0 (2026-01-02)
- Added template save/load system
- Fixed template loading (all properties restored)
- Improved toolbar layout
- All buttons now visible
- Enhanced JSON serialization

==========================================
SUPPORT
==========================================

For issues or questions, refer to the source code
or contact your developer.

==========================================
Created with Claude Code
==========================================
