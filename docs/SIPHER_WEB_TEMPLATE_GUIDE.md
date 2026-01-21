# Sipher Web Template - Implementation Guide

## Overview
Recreate the professional Sipher Web (sipherwebtech.com) design in the ImGui Website Designer.

## Screenshot Analysis

### Color Palette
```
Primary Colors:
- Deep Blue/Purple: #1a1a4d (top bar background)
- Navy Blue: #0d0d3a (hero background overlay)
- Bright Orange: #FF8C00 (CTA buttons, accents)
- Gold/Yellow: #FFD700 (logo background, "innovation" text)
- White: #FFFFFF (text, navigation background)

Glass Effect Colors:
- Glass Card BG: rgba(26, 26, 77, 0.4) with blur
- Glass Card Border: rgba(255, 255, 255, 0.2)
- Card Text: #FFFFFF
```

### Typography
```
Top Bar:
- Font: Sans-serif
- Size: 14px
- Weight: 400-500

Logo:
- Company Name: 24px, Bold (700)

Navigation:
- Menu Items: 16px, Medium (500)

Hero:
- Badge: 12px, Uppercase, Letter-spacing: 1.5px
- Main Heading: 56px, Bold (700)
- Subheading: 20px, Regular (400)

Feature Cards:
- Icon: 48px
- Title: 22px, Semibold (600)
- Description: 16px, Regular (400)

Buttons:
- Text: 16px, Medium (500)
```

---

## Template Structure (Sections)

### Section 1: Top Announcement Bar
**Type:** Custom Section (Header Bar)
**Height:** 45px
**Background:** #1a1a4d

**Content:**
- Left: "Trusted by 100+ Enterprise Clients Worldwide" (white with link icon)
- Center: "Delivering **innovation** & **Excellence** Since 2022" (white with orange highlights)
- Right: "Join Our **Growing Community** of Tech Enthusiasts" (white with orange highlights)
- Far Right: "Contact Us: +91 8318230713" (with phone icon)

**Properties:**
```
Background Color: RGB(26, 26, 77, 1)
Text Color: RGB(255, 255, 255, 1)
Accent Color (for highlighted words): RGB(255, 140, 0, 1)
Padding: 10px vertical, 40px horizontal
Font Size: 14px
Font Weight: 400
```

### Section 2: Navigation Bar
**Type:** Navbar
**Height:** 80px
**Background:** White
**Style:** Sticky/Fixed

**Logo:**
- Text: "SW" (Yellow background circle)
- Company Name: "Sipher Web Pvt. Ltd." (Navy blue, 24px)

**Menu Items:**
1. 🏠 Home (with home icon, orange)
2. 🏢 Company ▼ (dropdown)
3. 💼 Services ▼ (dropdown)
4. ⚙️ Products
5. 📁 Portfolio
6. 📝 Blog
7. 💬 Contact

**Properties:**
```
Background Color: RGB(255, 255, 255, 1)
Text Color: RGB(13, 13, 58, 1)
Hover Color: RGB(255, 140, 0, 1)
Font Size: 16px
Font Weight: 500
Logo Background: RGB(255, 215, 0, 1)
Logo Text Color: RGB(13, 13, 58, 1)
Shadow: 0 2px 10px rgba(0,0,0,0.05)
```

### Section 3: Hero Section
**Type:** Hero
**Height:** 900px
**Background Image:** Dark coding screen (with HTML/CSS code visible)

**Background Overlay:**
- Color: rgba(13, 13, 58, 0.85)
- Opacity: 0.85

**Layout:** Centered content

**Content Structure:**

1. **Top Badge:**
   ```
   Text: "MAXIMIZE YOUR ONLINE REVENUE"
   Style: Small pill badge
   Background: rgba(255, 255, 255, 0.1)
   Border: 1px solid rgba(255, 255, 255, 0.3)
   Text Color: White
   Padding: 8px 20px
   Border Radius: 20px
   Font Size: 12px
   Letter Spacing: 1.5px
   Uppercase: Yes
   ```

2. **Main Glass Card:**
   ```
   Width: 860px
   Background: rgba(26, 26, 77, 0.4)
   Backdrop Filter: Blur(10px)
   Border: 2px solid rgba(255, 255, 255, 0.2)
   Border Radius: 16px
   Padding: 50px

   Heading: "E-Commerce Excellence"
   - Font Size: 56px
   - Font Weight: 700
   - Color: White
   - Text Align: Center

   Subheading: "Powerful e-commerce solutions with seamless payment processing, inventory management, and customer analytics."
   - Font Size: 20px
   - Font Weight: 400
   - Color: rgba(255, 255, 255, 0.9)
   - Text Align: Center
   - Line Height: 1.6
   ```

3. **Three Feature Cards (Below Main Card):**

   **Card Layout:**
   - Display: Flex, 3 columns
   - Gap: 20px
   - Margin Top: 40px

   **Card 1 - Secure:**
   ```
   Icon: 🛡️ Shield
   Title: "Secure"
   Description: "Protected Payments"

   Background: rgba(26, 26, 77, 0.5)
   Border: 1px solid rgba(255, 255, 255, 0.15)
   Border Radius: 12px
   Padding: 30px
   Width: 280px

   Icon Color: RGB(100, 150, 255)
   Title Size: 22px
   Title Weight: 600
   Description Size: 16px
   Description Color: rgba(255, 255, 255, 0.7)
   ```

   **Card 2 - Analytics:**
   ```
   Icon: 📊 Bar Chart
   Title: "Analytics"
   Description: "Data Insights"

   (Same styling as Card 1)
   Icon Color: RGB(100, 200, 150)
   ```

   **Card 3 - Scalable:**
   ```
   Icon: 🚀 Rocket
   Title: "Scalable"
   Description: "Growth Ready"

   (Same styling as Card 1)
   Icon Color: RGB(255, 150, 100)
   ```

4. **Primary CTA Button:**
   ```
   Text: "Transform Your Store →"

   Background: Linear gradient or solid white
   Background Color: RGB(255, 255, 255, 1)
   Text Color: RGB(13, 13, 58, 1)
   Font Size: 18px
   Font Weight: 600
   Padding: 16px 40px
   Border Radius: 30px
   Border: None
   Box Shadow: 0 10px 30px rgba(255, 255, 255, 0.2)

   Hover:
   - Background: RGB(255, 140, 0, 1)
   - Text Color: White
   - Transform: translateY(-2px)
   - Shadow: 0 15px 40px rgba(255, 140, 0, 0.4)
   ```

5. **Bottom Action Buttons (3 buttons):**

   **Button 1 - Visit Academy:**
   ```
   Icon: 🎓 (graduation cap)
   Text: "Visit Academy Website"

   Background: RGB(255, 255, 255, 1)
   Text Color: RGB(13, 13, 58, 1)
   Border: 2px solid RGB(255, 255, 255, 1)
   Padding: 12px 30px
   Border Radius: 8px
   Font Size: 16px
   Font Weight: 500
   ```

   **Button 2 - Follow:**
   ```
   Icon: 👥 (people)
   Text: "Follow"

   Background: RGB(255, 255, 255, 1)
   Text Color: RGB(13, 13, 58, 1)
   (Same styling as Button 1)
   ```

   **Button 3 - Request Callback:**
   ```
   Icon: 📞 (phone)
   Text: "Request a Callback"

   Background: RGB(255, 140, 0, 1)
   Text Color: RGB(255, 255, 255, 1)
   Border: None
   Padding: 12px 30px
   Border Radius: 8px
   Font Size: 16px
   Font Weight: 500
   Box Shadow: 0 8px 20px rgba(255, 140, 0, 0.3)
   ```

**Hero Section Properties:**
```
Height: 900px
Background Image: Upload dark coding screen image
Background Size: Cover
Background Position: Center
Background Overlay: 0.85 opacity

Padding Top: 120px
Padding Bottom: 80px
Text Align: Center
```

---

## Step-by-Step Implementation

### Step 1: Prepare Background Image
1. Find or create a dark coding screen image (HTML/CSS code visible)
2. Recommended size: 1920x1080 or higher
3. Dark theme with blue/purple tones
4. Code should be visible but blurred slightly

### Step 2: Launch Website Designer
```bash
cd /Users/imaging/Desktop/Website-Builder-v2.0
./imgui_website_designer
```

### Step 3: Create Top Bar Section
1. Click "+ Custom" section
2. Set properties:
   - Name: "Top Announcement Bar"
   - Height: 45px
   - Background Color: RGB(26, 26, 77, 1)
   - Text Color: RGB(255, 255, 255, 1)
3. Add content text (will need HTML for colored keywords)

### Step 4: Create Navigation
1. Click "+ Navbar"
2. Upload logo or create "SW" text logo
3. Add menu items:
   - Home, Company, Services, Products, Portfolio, Blog, Contact
4. Set colors:
   - Background: White
   - Text: Navy blue
   - Hover: Orange

### Step 5: Create Hero Section
1. Click "+ Hero"
2. Choose "Centered Content" layout
3. Upload background image (coding screen)
4. Set background overlay opacity: 0.85
5. Add content:
   - Title: "E-Commerce Excellence"
   - Subtitle: "Powerful e-commerce solutions..."
   - Button: "Transform Your Store"
6. Customize colors to match design

### Step 6: Add Feature Cards
**Option A: Use Cards Section**
1. Click "+ Cards"
2. Add 3 cards
3. Set layout: 3 columns
4. Configure each card with icon, title, description

**Option B: Add to Hero Section**
(This might require custom HTML in export)

### Step 7: Style the Glass Effect
**Note:** Glass effect (backdrop-filter: blur) needs to be added in CSS export
The builder can approximate with:
- Semi-transparent backgrounds
- Light borders
- Shadows

### Step 8: Add Bottom CTA Buttons
1. Add another Custom section or extend Hero
2. Add 3 buttons with icons
3. Style each button according to specs

### Step 9: Fine-Tune Colors
Go through each section and match exact colors:
- Deep blue: #1a1a4d
- Orange: #FF8C00
- White: #FFFFFF
- Glass card background: rgba(26, 26, 77, 0.4)

### Step 10: Save Template
1. Click "Save Template" in menu
2. Name: "Sipher Web - E-Commerce Agency"
3. Description: "Professional tech agency website with glass morphism design"
4. Click Save - template stores to MySQL

---

## Quick Build Checklist

- [ ] Top announcement bar created (dark blue)
- [ ] Navigation bar added with logo and menu
- [ ] Hero section with coding background image
- [ ] Background overlay set to 0.85 opacity
- [ ] Main heading "E-Commerce Excellence" styled
- [ ] Subheading text added
- [ ] Three feature cards created (Secure, Analytics, Scalable)
- [ ] Glass effect styling applied
- [ ] Primary CTA button "Transform Your Store" added
- [ ] Three bottom action buttons added
- [ ] Colors matched to original design
- [ ] Typography sizes matched
- [ ] Template saved to database

---

## Database Template Structure

When saved, the template will include:
- Section data (JSON serialized)
- Background images (BLOB)
- Color schemes
- Typography settings
- All content and properties

**Template Name:** "Sipher Web - E-Commerce Agency"
**Category:** "Technology / Agency"
**Tags:** "tech, agency, e-commerce, glass morphism, modern, professional"

---

## Export Notes

When exporting to HTML/CSS:

1. **Glass Effect CSS:**
```css
.glass-card {
    background: rgba(26, 26, 77, 0.4);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 2px solid rgba(255, 255, 255, 0.2);
    border-radius: 16px;
}
```

2. **Button Hover Effects:**
```css
.cta-button {
    transition: all 0.3s ease;
}

.cta-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 40px rgba(255, 140, 0, 0.4);
}
```

3. **Responsive Design:**
```css
@media (max-width: 768px) {
    .hero-heading {
        font-size: 36px;
    }
    .feature-cards {
        flex-direction: column;
    }
}
```

---

## Alternative: Direct Database Import

If you want to skip manual building, I can create a SQL script to directly insert this template into the database. This would include:
- Complete section configuration
- All styling and properties
- Pre-configured layout

Would you like me to create the SQL import script?

---

## Color Reference Card

```
┌─────────────────────────────────────────┐
│  SIPHER WEB COLOR PALETTE               │
├─────────────────────────────────────────┤
│  Primary Navy:     #0d0d3a  ████████   │
│  Deep Blue:        #1a1a4d  ████████   │
│  Bright Orange:    #FF8C00  ████████   │
│  Gold:             #FFD700  ████████   │
│  White:            #FFFFFF  ████████   │
│  Glass BG:         rgba(26, 26, 77, 0.4) │
│  Glass Border:     rgba(255, 255, 255, 0.2) │
└─────────────────────────────────────────┘
```

---

## Tips for Best Results

1. **Background Image:** Use a high-quality coding screenshot with dark theme
2. **Glass Effect:** Set semi-transparent backgrounds with light borders
3. **Spacing:** Maintain generous padding and margins for clean look
4. **Consistency:** Use the same border-radius (12-16px) throughout
5. **Shadows:** Add subtle shadows for depth
6. **Icons:** Use consistent icon style (outline or solid)
7. **Animation:** Add hover effects to buttons and cards
8. **Typography:** Maintain hierarchy with size and weight

---

## Next Steps

1. **Build in Designer:** Follow steps above to create template manually
2. **Save Template:** Store in database for reuse
3. **Export:** Generate HTML/CSS for deployment
4. **Customize:** Modify for your specific use case

This template serves as an excellent foundation for:
- Tech agencies
- SaaS companies
- E-commerce platforms
- Digital marketing agencies
- Software companies

---

**Template Status:** Ready to build
**Estimated Time:** 30-45 minutes
**Difficulty:** Intermediate
**Style:** Modern, Professional, Glass Morphism
