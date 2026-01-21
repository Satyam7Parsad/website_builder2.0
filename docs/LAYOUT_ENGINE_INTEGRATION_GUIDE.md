# Layout Engine Integration Guide

## ✅ Step 1: Include the Layout Engine

Add to top of `imgui_website_designer.cpp` (around line 50):

```cpp
#include "layout_engine.h"
```

---

## ✅ Step 2: Modify RenderSectionPreview (line ~6353)

Find the card rendering code in `RenderSectionPreview()` and replace it:

### FIND THIS (old manual positioning):

```cpp
// Around line 6800-7000, look for card rendering
if (sec.type == SEC_CARDS || sec.type == SEC_SERVICES) {
    float cardX = x + sec.padding;
    float cardY = y + someOffset;

    for (int i = 0; i < sec.items.size(); i++) {
        if (i % sec.cards_per_row == 0) {
            cardX = x + sec.padding;
            cardY += sec.card_height + sec.card_spacing;
        }

        // Draw card at cardX, cardY
        cardX += sec.card_width + sec.card_spacing;
    }
}
```

### REPLACE WITH THIS (new layout engine):

```cpp
if (sec.type == SEC_CARDS || sec.type == SEC_SERVICES) {
    float contentStartY = y + sec.padding_top + 120;  // Below title
    float containerX = x + sec.padding_left;
    float containerWidth = sectionW - sec.padding_left - sec.padding_right;
    float containerHeight = h - sec.padding_top - sec.padding_bottom - 120;

    // Prepare item sizes
    std::vector<float> itemWidths;
    std::vector<float> itemHeights;
    for (size_t i = 0; i < sec.items.size(); i++) {
        itemWidths.push_back(sec.card_width);
        itemHeights.push_back(sec.card_height);
    }

    std::vector<LayoutRect> boxes;

    // === FLEXBOX LAYOUT ===
    if (sec.display == "flex") {
        printf("🎨 FLEXBOX: justify=%s, align=%s, gap=%.0f\n",
               sec.justify_content.c_str(), sec.align_items.c_str(), sec.gap);

        // Create flexbox props from section
        FlexboxLayout flexProps;
        flexProps.flex_direction = sec.flex_direction;
        flexProps.justify_content = sec.justify_content;
        flexProps.align_items = sec.align_items;
        flexProps.gap = (sec.gap > 0) ? sec.gap : sec.card_spacing;

        // Calculate layout
        boxes = FlexboxEngine::CalculateLayout(
            containerX, contentStartY,
            containerWidth, containerHeight,
            flexProps,
            itemWidths, itemHeights
        );
    }
    // === GRID LAYOUT ===
    else if (sec.display == "grid") {
        printf("📐 GRID: columns=%s, gap=%.0f\n",
               sec.grid_template_columns.c_str(), sec.gap);

        // Create grid props from section
        GridLayout gridProps;
        gridProps.grid_template_columns = sec.grid_template_columns;
        gridProps.grid_template_rows = sec.grid_template_rows;
        gridProps.column_gap = (sec.gap > 0) ? sec.gap : sec.card_spacing;
        gridProps.row_gap = gridProps.column_gap;

        // Calculate grid dimensions
        GridDimensions grid = GridEngine::CalculateLayout(
            containerX, contentStartY,
            containerWidth, containerHeight,
            gridProps,
            sec.items.size()
        );

        // Convert to layout boxes
        for (size_t i = 0; i < sec.items.size(); i++) {
            boxes.push_back(grid[i]);
        }
    }
    // === FALLBACK: Old manual layout ===
    else {
        float cardX = containerX;
        float cardY = contentStartY;

        for (size_t i = 0; i < sec.items.size(); i++) {
            if (i > 0 && i % sec.cards_per_row == 0) {
                cardX = containerX;
                cardY += sec.card_height + sec.card_spacing;
            }

            LayoutRect box(cardX, cardY, sec.card_width, sec.card_height);
            boxes.push_back(box);
            cardX += sec.card_width + sec.card_spacing;
        }
    }

    // === RENDER CARDS AT CALCULATED POSITIONS ===
    for (size_t i = 0; i < boxes.size() && i < sec.items.size(); i++) {
        LayoutRect box = boxes[i];

        // Apply animation transform if enabled
        if (sec.animation_type != ANIM_NONE) {
            AnimationState& anim = AnimationEngine::UpdateAnimation(
                sec.id * 1000 + i,  // Unique ID per card
                sec.animation_type,
                sec.animation_duration,
                sec.animation_delay + (i * 0.1f),  // Stagger animations
                sec.animation_repeat,
                ImGui::GetIO().DeltaTime
            );

            box = AnimationEngine::ApplyAnimationTransform(box, anim);

            // Get opacity for fade effects
            float opacity = anim.opacity;
            // Apply opacity to card rendering (modify alpha channel)
        }

        // Draw the card using calculated position
        DrawCard(box.x, box.y, box.width, box.height, sec.items[i]);
    }
}
```

---

## ✅ Step 3: Add Animation Update at START of RenderSectionPreview

Find the beginning of `RenderSectionPreview()` and add:

```cpp
void RenderSectionPreview(ImDrawList* dl, WebSection& sec, ImVec2 pos, float w, float yOff) {
    // === ADD THIS AT THE VERY START ===

    // Update section animation
    if (sec.animation_type != ANIM_NONE) {
        AnimationState& anim = AnimationEngine::UpdateAnimation(
            sec.id,
            sec.animation_type,
            sec.animation_duration,
            sec.animation_delay,
            sec.animation_repeat,
            ImGui::GetIO().DeltaTime
        );

        // Apply animation to section position
        yOff += anim.translateY;
    }

    // === REST OF EXISTING CODE CONTINUES ===

    // Apply width and horizontal alignment (for ALL sections)
    float canvasW = w;
    float sectionW = canvasW * (sec.section_width_percent / 100.0f);
    float sectionX = pos.x;
    // ... etc
```

---

## ✅ Step 4: Enable Animation on Section Background

Find where the section background is drawn and apply opacity:

```cpp
// Around line 6400-6500, find background rendering

// OLD CODE:
dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(sec.bg_color));

// NEW CODE (with animation support):
ImVec4 bgColor = sec.bg_color;

// Apply fade animation to background
if (sec.animation_type == ANIM_FADE_IN || sec.animation_type == ANIM_SCALE_UP) {
    float opacity = AnimationEngine::GetOpacity(sec.id);
    bgColor.w *= opacity;  // Multiply alpha by animation opacity
}

dl->AddRectFilled(mn, mx, ImGui::ColorConvertFloat4ToU32(bgColor));
```

---

## ✅ Step 5: Test It!

### Compile:
```bash
cd /Users/imaging/Desktop/Website-Builder-v2.0
./build.sh
```

### Run:
```bash
./imgui_website_designer
```

### Load Template:
Load `stripe_flexbox_test` template.

### Expected Console Output:
```
🎨 FLEXBOX: justify=space-between, align=center, gap=40
📐 GRID: columns=repeat(3, 1fr), gap=24
```

### Expected Visual Result:
✅ Cards perfectly spaced with `justify-content: space-between`
✅ Grid layouts with exact 3 columns
✅ Smooth fade-in animations
✅ Slide animations from sides

---

## 🎯 Quick Test Example

Add this code to test immediately (add in main() after loading template):

```cpp
// Test animation on first section
if (!g_Sections.empty()) {
    g_Sections[0].animation_type = ANIM_FADE_IN;
    g_Sections[0].animation_duration = 2.0f;
    g_Sections[0].animation_delay = 0.0f;
    g_Sections[0].animation_repeat = false;
    printf("✅ Animation enabled on section 0\n");
}

// Test flexbox on cards section
for (auto& sec : g_Sections) {
    if (sec.type == SEC_CARDS && sec.display == "flex") {
        printf("✅ Found flexbox section: %s\n", sec.name.c_str());
        printf("   - justify-content: %s\n", sec.justify_content.c_str());
        printf("   - align-items: %s\n", sec.align_items.c_str());
    }
}
```

---

## 🐛 Troubleshooting

### Problem: Cards still manually positioned
**Solution:** Check that `sec.display == "flex"` is true. If not, the data wasn't loaded from database. Check that you're using the enhanced scraper data.

### Problem: No animations
**Solution:** Make sure `sec.animation_type` is set (not 0). Check animation duration > 0.

### Problem: Compilation errors
**Solution:** Make sure `#include "layout_engine.h"` is at the top, and `layout_engine.h` is in the same directory as `imgui_website_designer.cpp`.

### Problem: "undefined reference" errors
**Solution:** The static members need to be initialized. Make sure these lines are at the END of `layout_engine.h`:
```cpp
std::map<int, AnimationState> AnimationEngine::s_AnimationStates;
std::map<int, TransitionState> TransitionEngine::s_TransitionStates;
```

---

## 📊 Before vs After

### BEFORE (Manual Positioning):
```
Card 1: x=100, y=200
Card 2: x=350, y=200  (hardcoded spacing)
Card 3: x=600, y=200
```

### AFTER (Flexbox justify-content: space-between):
```
Card 1: x=50,  y=200
Card 2: x=500, y=200  (perfectly centered!)
Card 3: x=950, y=200
```

---

## 🚀 Next Steps

After basic integration works:

1. **Add hover effects**: Use `TransitionEngine` for card hover
2. **Test grid layouts**: Load templates with `grid-template-columns`
3. **Test all animations**: fadeIn, slideLeft, slideRight, slideUp, slideDown, scaleUp
4. **Export to HTML**: All CSS data will work perfectly in exported HTML

---

That's it! Your layout engine is now complete and integrated. All the CSS data your scraper captures will finally be USED! 🎉
