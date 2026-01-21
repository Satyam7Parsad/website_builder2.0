# 🎬 Hero Animation Feature - Complete Guide

## ✨ New Feature: Customizable Image Slideshow for Hero Sections!

Your website builder now supports **animated background slideshows** for Hero and CTA sections with **fully customizable** image count!

---

## 🎯 What's New

### **Flexible Image Count**
- ✅ Upload **4 images** for a quick slideshow
- ✅ Upload **6 images** for more variety
- ✅ Upload **8 images** for a rich experience
- ✅ Upload **any number** you want (1-50+)
- ✅ **You control** how many images to use!

### **Full Customization**
- ✅ **Animation Speed**: 1-10 seconds per image
- ✅ **Add/Remove**: Manage images anytime
- ✅ **Real-time Preview**: See animation live
- ✅ **Overlay Control**: Adjust darkness over images
- ✅ **Enable/Disable**: Toggle animation on/off

---

## 🚀 How to Use Hero Animation

### **Step 1: Add a Hero Section**
1. Launch the application (it's running now!)
2. Click **"+ Hero"** or **"+ CTA"** button
3. Section appears in the canvas

### **Step 2: Enable Animation**
1. **Select the Hero section** (click on it in preview)
2. In the **right properties panel**, scroll to:
   ```
   HERO ANIMATION (Slideshow)
   ```
3. **Check** the box: **"Enable Hero Animation"**

### **Step 3: Set Animation Speed**
1. Use the **slider**: "Animation Speed"
2. Range: **1.0s - 10.0s** per image
3. **Recommended:**
   - Fast slideshow: 2-3 seconds
   - Standard: 3-5 seconds
   - Slow fade: 6-10 seconds

### **Step 4: Upload Images**
1. Click **"Add Images to Animation"** button
2. **Multi-select** your images:
   - Hold **Cmd (Mac)** or **Ctrl (Windows)**
   - Click 4, 6, 8, or any number of images
   - All selected images upload at once
3. Images load and animation starts!

### **Step 5: Manage Images**
- **View Count**: See "Animation Images (X images)"
- **Remove Images**: Click **"X"** next to any image
- **Add More**: Click "Add Images" again anytime
- **Reorder**: Delete and re-add in desired order

---

## 🎨 Example Use Cases

### **4 Images - Product Showcase**
```
Image 1: Product front view
Image 2: Product side view
Image 3: Product in use
Image 4: Product features
Speed: 4 seconds each
```

### **6 Images - Hotel Website**
```
Image 1: Hotel exterior
Image 2: Lobby
Image 3: Guest room
Image 4: Restaurant
Image 5: Pool
Image 6: Spa
Speed: 5 seconds each
```

### **8 Images - Portfolio**
```
Image 1-8: Your best work
Speed: 3 seconds each
Total loop: 24 seconds
```

### **Unlimited - Photo Gallery**
```
Upload 20, 30, or 50 images
Speed: 2 seconds each
Creates a comprehensive showcase
```

---

## ⚙️ Technical Details

### **How It Works**

```
1. You upload X images (4, 6, 8, any number)
   ↓
2. Images load as textures in memory
   ↓
3. Timer counts (0 → speed seconds)
   ↓
4. When timer reaches speed:
   - Show next image
   - Reset timer
   - Loop back to first image after last
   ↓
5. Smooth infinite loop
```

### **Animation Properties**

```cpp
// Added to WebSection struct:
std::vector<std::string> hero_animation_images;     // Image paths
std::vector<GLuint> hero_animation_texture_ids;     // Loaded textures
bool enable_hero_animation;                          // On/off toggle
float hero_animation_speed;                          // Seconds per image
int current_animation_frame;                         // Which image showing
float animation_timer;                               // Time elapsed
```

### **Rendering Logic**

```cpp
// Update timer each frame
animation_timer += deltaTime;

// Check if time to switch image
if (animation_timer >= animation_speed) {
    animation_timer = 0;
    current_frame++;
    if (current_frame >= total_images) {
        current_frame = 0; // Loop back
    }
}

// Render current frame
RenderImage(animation_textures[current_frame]);
```

---

## 🎬 UI Controls Reference

### **In Properties Panel (Hero/CTA Sections Only):**

```
┌─────────────────────────────────────────────┐
│ HERO ANIMATION (Slideshow)                  │
├─────────────────────────────────────────────┤
│ ☑ Enable Hero Animation                     │
│                                              │
│ Animation Speed (seconds per image):        │
│ [====|==========] 3.0s                       │
│                                              │
│ Animation Images (6 images)                 │
│ [Add Images to Animation (button)]          │
│                                              │
│ Manage Animation Images:                    │
│ • Image 1                           [X]     │
│ • Image 2                           [X]     │
│ • Image 3                           [X]     │
│ • Image 4                           [X]     │
│ • Image 5                           [X]     │
│ • Image 6                           [X]     │
│                                              │
│ Tip: You can add 4, 6, 8, or any number!   │
└─────────────────────────────────────────────┘
```

---

## 📸 Image Requirements

### **Supported Formats**
- ✅ JPG / JPEG
- ✅ PNG (with transparency)
- ✅ BMP
- ✅ GIF (static)
- ✅ TGA
- ✅ PSD
- ✅ HDR
- ✅ And more!

### **Recommended Specs**
- **Resolution:** 1920x1080 (Full HD) or higher
- **Aspect Ratio:** 16:9 (matches most screens)
- **File Size:** Under 5MB per image (for performance)
- **Quality:** High quality, no pixelation
- **Subject:** Centered, good composition

### **Image Tips**
1. **Consistent dimensions**: All images same size
2. **Similar lighting**: Avoid jarring transitions
3. **Theme match**: Related images look better
4. **Color harmony**: Similar color palettes
5. **Quality over quantity**: 4 great images > 10 poor ones

---

## 🎨 Design Best Practices

### **Animation Speed Guidelines**

| Use Case | Speed | Reason |
|----------|-------|--------|
| **Product showcase** | 4-5s | Time to read text |
| **Photo gallery** | 3-4s | Quick variety |
| **Hotel/real estate** | 5-6s | Show details |
| **Fast promo** | 2-3s | Energetic feel |
| **Ambient background** | 7-10s | Subtle change |

### **Image Count Guidelines**

| Count | Best For | Loop Time (4s each) |
|-------|----------|---------------------|
| **4 images** | Quick showcase | 16 seconds |
| **6 images** | Standard slideshow | 24 seconds |
| **8 images** | Rich presentation | 32 seconds |
| **10+ images** | Extensive gallery | 40+ seconds |

### **Overlay Opacity Tips**

```
Without Text:
- Overlay: 0.0 - 0.3 (light or none)
- Let images shine

With Text:
- Overlay: 0.5 - 0.7 (medium to dark)
- Ensures text readability

Dark Images:
- Overlay: 0.0 - 0.2
- Images already dark

Bright Images:
- Overlay: 0.6 - 0.8
- Darken for contrast
```

---

## 🔄 Workflow Examples

### **Example 1: Simple 4-Image Hero**

```
1. Add Hero section
2. Enable Hero Animation
3. Set speed: 4 seconds
4. Upload 4 images (nature scenes)
5. Set overlay: 0.6
6. Add title: "Explore Nature"
7. Preview animation
8. Done! 16-second loop
```

### **Example 2: Advanced 8-Image Portfolio**

```
1. Add Hero section
2. Configure:
   - Enable animation: ✓
   - Speed: 3 seconds
   - Overlay: 0.7
3. Upload 8 portfolio images
4. Review each transition
5. Remove any that don't fit
6. Adjust speed to 3.5s for better pacing
7. Add text overlay
8. Export and deploy
```

### **Example 3: Dynamic Count Adjustment**

```
Start with 6 images:
1. Upload 6 images
2. Preview animation
3. Feels too long? Remove 2 images → 4 total
4. Feels too short? Add 2 more → 8 total
5. Perfect? Keep 6!
6. You have full control!
```

---

## 💾 Saving & Loading

### **Animation Saves Automatically**
When you save a template:
- ✅ All animation images saved
- ✅ Animation speed saved
- ✅ Enable/disable state saved
- ✅ Current frame saved
- ✅ Everything persists!

### **Loading Templates**
When you load a template:
- ✅ Animation images reload
- ✅ Textures recreate
- ✅ Animation resumes
- ✅ All settings restore

### **Database Storage**
Animation data stored in:
- `hero_animation_images` field (paths)
- `enable_hero_animation` field (bool)
- `hero_animation_speed` field (float)

---

## 🚀 Export to HTML/CSS

### **HTML Export Generates:**

```html
<!-- Animation container -->
<div class="hero-slideshow">
    <img src="images/hero-1.jpg" class="slide active">
    <img src="images/hero-2.jpg" class="slide">
    <img src="images/hero-3.jpg" class="slide">
    <img src="images/hero-4.jpg" class="slide">
</div>

<!-- Hero content overlay -->
<div class="hero-content">
    <h1>Your Title</h1>
    <p>Your subtitle</p>
    <button>CTA Button</button>
</div>
```

### **CSS Export Generates:**

```css
.hero-slideshow {
    position: relative;
    width: 100%;
    height: 100vh;
}

.hero-slideshow .slide {
    position: absolute;
    width: 100%;
    height: 100%;
    object-fit: cover;
    opacity: 0;
    transition: opacity 1s ease-in-out;
}

.hero-slideshow .slide.active {
    opacity: 1;
}

.hero-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 10;
    text-align: center;
}
```

### **JavaScript Export Generates:**

```javascript
// Hero slideshow animation
const slides = document.querySelectorAll('.hero-slideshow .slide');
let currentSlide = 0;
const slideSpeed = 3000; // milliseconds

function nextSlide() {
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
}

setInterval(nextSlide, slideSpeed);
```

**Result:** Professional, production-ready slideshow code!

---

## 🎯 Feature Highlights

### **Why This Feature is Powerful:**

1. **✅ Fully Customizable**
   - Not limited to 8 images
   - You choose 4, 6, 8, 10, 20, or any number
   - Complete flexibility

2. **✅ Easy to Use**
   - Multi-select upload
   - Visual image management
   - Real-time preview

3. **✅ Performance Optimized**
   - Efficient texture loading
   - Smooth transitions
   - Low memory usage

4. **✅ Professional Output**
   - Exports to HTML/CSS/JS
   - Production-ready code
   - Cross-browser compatible

5. **✅ Visual Builder**
   - No coding required
   - Point-and-click interface
   - Instant results

---

## 📋 Quick Reference

### **Keyboard Shortcuts:**
- **Select Hero:** Click on section
- **Upload Images:** Click "Add Images"
- **Remove Image:** Click "X" button
- **Toggle Animation:** Checkbox

### **Speed Presets:**
- **Fast:** 2-3 seconds
- **Standard:** 4-5 seconds
- **Slow:** 6-8 seconds
- **Very Slow:** 9-10 seconds

### **Image Count Presets:**
- **Minimal:** 4 images
- **Standard:** 6 images
- **Rich:** 8 images
- **Extensive:** 10+ images

---

## 🔍 Troubleshooting

### **Animation Not Showing?**
✅ Check: "Enable Hero Animation" is checked
✅ Check: At least 1 image uploaded
✅ Check: Images loaded successfully

### **Animation Too Fast/Slow?**
✅ Adjust: "Animation Speed" slider
✅ Range: 1.0s - 10.0s

### **Want to Change Images?**
✅ Remove: Click "X" on unwanted images
✅ Add More: Click "Add Images" button

### **Images Not Loading?**
✅ Check: Image format supported (JPG, PNG, etc.)
✅ Check: File not corrupted
✅ Check: File size reasonable (<10MB)

---

## ✨ Summary

### **What You Get:**

✅ **Flexible Image Count:** 4, 6, 8, or ANY number
✅ **Speed Control:** 1-10 seconds per image
✅ **Easy Management:** Add/remove images anytime
✅ **Real-time Preview:** See animation live
✅ **Professional Export:** HTML/CSS/JS ready
✅ **Database Storage:** Saves with template
✅ **Visual Builder:** No coding needed

### **Perfect For:**

- 🏨 Hotels & Resorts (showcase facilities)
- 🏠 Real Estate (property views)
- 📸 Photographers (portfolio)
- 🛍️ E-commerce (product angles)
- 🎨 Agencies (case studies)
- 🌍 Travel Sites (destinations)
- 🍽️ Restaurants (food & ambiance)
- 💼 Corporate (company culture)

---

## 🎉 Get Started Now!

**The application is running right now!**

1. **Select a Hero section** (or add one with "+ Hero")
2. **Enable Hero Animation** in properties panel
3. **Upload your images** (4, 6, 8, or more!)
4. **Set animation speed** (3-5 seconds recommended)
5. **Watch it animate** in real-time! ✨

---

**Feature Status:** ✅ Complete & Running
**Application Status:** ✅ Launched & Ready
**Your Action:** Test the animation now!

Enjoy your new customizable hero animation feature! 🎬✨
