# 🎨 Logo Upload Feature Guide

## ✅ Feature Complete!

Logo image upload with brand text positioning control has been successfully implemented!

---

## 🚀 How to Use

### Step 1: Select Navigation Section
1. Launch the Website Builder app
2. In the **left panel**, select your template
3. Click on the **Navigation (Navbar)** section

### Step 2: Upload Logo Image
1. Look at the **right panel** (Properties Panel)
2. Scroll down to find the **"LOGO"** section
3. Click **"Upload Logo Image"** button
4. Select your logo file (supports: PNG, JPG, JPEG, GIF, BMP, WEBP)
5. ✅ Logo will load and show "Logo loaded" message

### Step 3: Configure Logo Settings

#### **Logo Size Control**
- Use the **"Logo Size"** slider
- Range: 30px - 150px
- Default: 50px
- Adjust to fit your design

#### **Brand Text Position Control**
Choose how your brand name appears with the logo:

**Option 1: Side (Next to Logo)** ← Default
```
┌──────────────────────────┐
│ [Logo] Brand  Menu Items │
└──────────────────────────┘
```
- Logo on the left
- Brand text on the right side
- Classic horizontal layout

**Option 2: Above Logo**
```
┌──────────────────────────┐
│   Brand                  │
│   [Logo]      Menu Items │
└──────────────────────────┘
```
- Brand text on top
- Logo below the text
- Stacked vertical layout

**Option 3: Below Logo**
```
┌──────────────────────────┐
│   [Logo]      Menu Items │
│   Brand                  │
└──────────────────────────┘
```
- Logo on top
- Brand text below the logo
- Inverted vertical layout

---

## 🎯 Features

✅ **Any Image Format**
- PNG (best for logos with transparency)
- JPG/JPEG
- GIF
- BMP
- WEBP

✅ **Automatic Rendering**
- Works in ImGui designer preview
- Works in Chrome WebAssembly preview
- Real-time updates

✅ **Size Control**
- Fully adjustable from 30px to 150px
- Maintains aspect ratio

✅ **Flexible Positioning**
- 3 brand text positions
- Easy switching via dropdown

✅ **Database Persistence**
- Logo path saved to database
- Size and position settings saved
- Loads automatically on app restart

---

## 📋 Example Workflow

1. **Create/Select Navigation Section**
2. **Upload Logo**: Click "Upload Logo Image" → Select your company logo (logo.png)
3. **Adjust Size**: Drag slider to 60px
4. **Choose Position**: Select "Side (Next to Logo)"
5. **Preview**: Click "Preview in Chrome" to see result
6. **Save**: Click "Save Template" to persist

---

## 🗄️ Database

New fields added to `sections` table:
- `logo_size` (REAL) - Logo size in pixels (default: 50.0)
- `brand_text_position` (INTEGER) - Position: 0=side, 1=above, 2=below

Migration script: `add_logo_fields.sql`

---

## 🔧 Technical Details

**Code Files Modified:**
- `imgui_website_designer.cpp` (lines 553-561, 818, 6702-6752, 5392-5429, 8603-8635)

**Properties Panel UI:**
- Upload button with file dialog
- Size slider (30-150px range)
- Position dropdown (3 options)
- Remove logo button

**Rendering:**
- ImGui preview: Real-time logo + text positioning
- Chrome preview: WebAssembly C++ code generation with logo

---

## 💡 Tips

- **Best Logo Format**: PNG with transparent background
- **Recommended Size**: 50-80px for most designs
- **High DPI**: Use 2x resolution images for sharp display
- **Testing**: Use Chrome preview to see final result

---

## ✅ Tested & Working

- ✅ Logo upload (all formats)
- ✅ Size adjustment (30-150px)
- ✅ Position control (Side/Above/Below)
- ✅ ImGui preview rendering
- ✅ Chrome WebAssembly preview
- ✅ Database save/load
- ✅ Template persistence

**Feature is 100% functional!** 🎉
