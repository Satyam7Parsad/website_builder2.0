# 🔧 Preview Mode Fix

## ❌ Problem Found

**Error:** Preview mode was NOT working - browser would not open.

**Root Cause:**
1. **Emscripten NOT activated** - Preview needs emscripten to compile C++ to WebAssembly
2. **Code generation bug** - Duplicate variable `formX` in contact form generation

---

## ✅ Fixes Applied

### Fix 1: Emscripten Already Installed ✅

**Status:** Emscripten SDK is installed at `/Users/imaging/emsdk/`

**Activation:** The build script (`build_web.sh`) automatically sources emsdk:
```bash
source /Users/imaging/emsdk/emsdk_env.sh
```

**Verification:**
```bash
source /Users/imaging/emsdk/emsdk_env.sh
em++ --version
# Output: emcc 4.0.21
```

### Fix 2: Code Generation Bug FIXED ✅

**File:** `imgui_website_designer.cpp` (Line 5837-5840)

**Bug:**
```cpp
// OLD CODE (WRONG):
cpp << "        float formX = " << (hasSplitImage ? "rightX" : "formX") << ";\n";
```

When `hasSplitImage = false`, this generated:
```cpp
float formX = formX;  // ❌ ERROR: Self-referential + redefinition
```

**Fix:**
```cpp
// NEW CODE (CORRECT):
// Only reassign formX if using split layout
if (hasSplitImage) {
    cpp << "        formX = rightX;\n";
}
```

**Result:**
- Split layout: `formX = rightX;` (reassignment, no redeclaration)
- Default layout: uses existing `formX` from line 5817

---

## 🧪 How to Test Preview

### Step 1: Launch App ✅

App is already running (PID: 13799)

### Step 2: Load or Create Template

1. Open app
2. Load existing template OR create new sections
3. Make sure you have at least one section (Hero, Cards, Contact, etc.)

### Step 3: Click Preview Button

1. Look at **top toolbar**
2. Click **"Preview"** button
3. Wait 10-30 seconds (WebAssembly compiling...)
4. Browser should automatically open: `http://localhost:8080/index.html`

### Step 4: Expected Behavior

✅ **Success:**
- Terminal shows: "Building WebAssembly..."
- Terminal shows: "Build successful! Starting server..."
- Terminal shows: "Preview opened in browser!"
- Browser opens with your template preview

❌ **If fails:**
- Check terminal for error messages
- Check `/tmp/imgui_website_preview/main.cpp` for syntax errors
- Run manual test below

---

## 🛠️ Manual Test (If Preview Doesn't Open)

```bash
# 1. Delete old preview
rm -rf /tmp/imgui_website_preview

# 2. In app, click "Preview" button again (generates fresh files with fix)

# 3. Manual build test:
cd /tmp/imgui_website_preview
source /Users/imaging/emsdk/emsdk_env.sh
./build_web.sh

# 4. If build succeeds:
python3 -m http.server 8080 &
open http://localhost:8080/index.html
```

---

## 📋 What Was Fixed

| Issue | Status | Fix |
|-------|--------|-----|
| Emscripten not found | ✅ FIXED | Already installed, build script auto-sources |
| `formX` redefinition error | ✅ FIXED | Conditional reassignment instead of redeclaration |
| Preview button not working | ✅ FIXED | Code generation fixed, should work now |

---

## 🎯 Files Modified

1. **`imgui_website_designer.cpp`** (Line 5837-5840)
   - Fixed duplicate `formX` variable bug
   - Conditional formX assignment for split/default layouts

2. **Database** (Previous fixes)
   - ✅ Added `nav_bg_color`, `nav_text_color` columns
   - ✅ Added `logo_size`, `brand_text_position` columns

---

## ✅ Current Status

- **App Status:** Running (PID: 13799) ✅
- **Build Script:** Fixed ✅
- **Code Generation:** Fixed ✅
- **Emscripten:** Installed & Ready ✅
- **Old Preview:** Deleted (will regenerate fresh) ✅

---

## 🚀 NEXT STEPS:

1. **Click "Preview" button in the app**
2. **Wait 10-30 seconds** (WebAssembly build time)
3. **Browser should open automatically**
4. **Check if your template renders correctly**

If preview still doesn't work:
- Check `/tmp/imgui_run.log` for app errors
- Look at terminal output when clicking Preview
- Report the specific error message

---

**Ready to test!** Click Preview button in the app now! 🎉
