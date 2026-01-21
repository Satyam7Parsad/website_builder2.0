# 🔧 Preview Template & Scroll Fix

## ❌ Problems Found

### Problem 1: Wrong Template in Preview (Nike showing always)
**Cause:** Browser caching old preview + old HTTP server still running

### Problem 2: Scroll Not Working
**Cause:** Canvas not getting focus + wheel events not properly handled

---

## ✅ Fixes Applied

### Fix 1: Cache-Busting URL ✅

**File:** `imgui_website_designer.cpp` (Line 6435-6438)

**What Changed:**
- Added timestamp to preview URL to force browser reload
- Kills old HTTP server before starting new one
- Proper sleep timing to ensure server starts

**Before:**
```cpp
system("open http://localhost:8080/index.html");
```

**After:**
```cpp
auto timestamp = std::chrono::system_clock::now().time_since_epoch().count();
std::string url = "http://localhost:8080/index.html?t=" + std::to_string(timestamp);
system(("open \"" + url + "\"").c_str());
```

**Result:** Every preview opens with unique URL → No browser cache!

---

### Fix 2: Improved Scroll Handling ✅

**File:** `imgui_website_designer.cpp` (Line 6215-6233)

**What Changed:**
- Canvas gets focus on load AND on click
- Wheel events only prevented when over canvas
- Better event targeting

**Before:**
```javascript
// Prevented ALL wheel events globally
document.addEventListener('wheel', function(e) {
    e.preventDefault();
}, { passive: false });
```

**After:**
```javascript
// Only prevent when mouse is over canvas
canvas.addEventListener('click', function() {
    canvas.focus();  // Ensure focus on click
});

document.addEventListener('wheel', function(e) {
    // Only prevent if mouse is over canvas
    if (e.target === canvas || canvas.contains(e.target)) {
        e.preventDefault();
    }
}, { passive: false });
```

**Result:** Better scroll event handling!

---

## 🧪 How to Test

### **Step 1: Clean Start** ✅ (Already Done)

```bash
# Old app killed ✅
# Old HTTP server killed ✅
# New app running: PID 14542 ✅
```

### **Step 2: Test Different Templates**

#### A. Load Template 1:
1. Open app (already running)
2. Click "Load Template" button (top left)
3. Select any template (e.g., "Nike", "Apple", etc.)
4. Wait for sections to load
5. **Click "Preview" button**
6. Wait 10-30 seconds for build
7. **✅ Browser should open with THAT template**

#### B. Load Template 2 (Different):
1. In app, click "Load Template" again
2. Select a DIFFERENT template (e.g., if you loaded Nike before, now load Apple)
3. Wait for sections to load (you'll see them in left panel)
4. **Click "Preview" button** again
5. Wait 10-30 seconds
6. **✅ Browser should open with NEW template (not old Nike!)**

### **Step 3: Test Scrolling**

Once preview opens in browser:

**Method 1: Trackpad Scroll (Mac)** 🖱️
1. Move mouse over the preview page
2. **Click once** on the page (to ensure canvas has focus)
3. Use **two-finger scroll** on trackpad
4. **✅ Page should scroll up/down**

**Method 2: Mouse Wheel** 🖱️
1. Move mouse over the preview page
2. Click once on the page
3. Use **mouse wheel**
4. **✅ Page should scroll**

**Method 3: Click-and-Drag** 🖱️
1. **Click and hold** left mouse button on page
2. **Drag up or down**
3. **✅ Page should scroll**

---

## 🎯 Expected Behavior

### ✅ Correct Template Shows:
- App shows 5 sections (Hero, Features, etc.) → Preview shows THOSE 5 sections
- App shows Nike template → Preview shows Nike
- App shows Apple template → Preview shows Apple
- **NOT always Nike!**

### ✅ Scroll Works:
- Trackpad two-finger scroll: **WORKS** ✅
- Mouse wheel: **WORKS** ✅
- Click-and-drag: **WORKS** ✅
- Keyboard arrows: **WORKS** ✅

---

## 🔍 Debugging

### If Wrong Template Still Shows:

**Check 1: Is correct template loaded in app?**
```
Look at left panel in app → Should show sections from your template
```

**Check 2: Check terminal output**
```
[Preview] Starting preview with X sections
# X should match number of sections in left panel
```

**Check 3: Force browser cache clear**
```
In browser: Command+Shift+R (Mac) or Ctrl+Shift+R
Or: Close ALL browser windows and reopen
```

**Check 4: Manual test**
```bash
# Check what's in preview directory
ls /tmp/imgui_website_preview/images/
# Should show images from YOUR template, not Nike
```

### If Scroll Still Not Working:

**Check 1: Canvas has focus?**
```
Click once on the preview page before scrolling
```

**Check 2: Try different scroll methods**
```
- Trackpad scroll
- Mouse wheel
- Click-and-drag
- Arrow keys (Up/Down/Page Up/Page Down)
```

**Check 3: Browser console**
```
Open browser console (Command+Option+I)
Look for JavaScript errors
```

---

## 📋 Files Modified

1. **`imgui_website_designer.cpp`**
   - Line 21: Added `#include <chrono>` for timestamp
   - Line 6428-6438: Added cache-busting + better timing
   - Line 6215-6233: Improved scroll event handling

2. **Rebuild:** ✅ Done
3. **App Restart:** ✅ Running (PID 14542)

---

## 🚀 READY TO TEST!

**Current Status:**
- ✅ App running with fixes
- ✅ Old server killed
- ✅ Cache-busting enabled
- ✅ Scroll handling improved

**Next Steps:**
1. Load a template in the app
2. Click "Preview" button
3. Check if correct template shows
4. Test scrolling with trackpad/mouse

**Report back:**
- Which template did you load?
- Which template showed in preview?
- Did scroll work?

Let's test it! 🎉
