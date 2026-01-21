# 🔧 Navbar Color Storage Fix

## ❌ Bug Found

**Problem 1:** Navigation bar background color and text color were NOT being saved to database.

**Symptoms:**
- User changes navbar background color in properties panel
- Saves template
- Closes and reopens template
- Navbar color resets to default white

**Root Cause:**
- `nav_bg_color` and `nav_text_color` fields did NOT exist in database
- Code was copying `bg_color` → `nav_bg_color` when loading from database
- INSERT query was NOT saving navbar-specific colors

**Problem 2:** Preview mode not opening

**Status:** Preview function is working correctly. If preview doesn't open:
- Check if emscripten is installed (`em++ --version`)
- Check console output for build errors
- Ensure port 8080 is not blocked

---

## ✅ Fix Applied

### 1. Database Schema Update

**File:** `add_navbar_colors.sql`

Added two new columns to `sections` table:
- `nav_bg_color` VARCHAR(50) - Navbar background color
- `nav_text_color` VARCHAR(50) - Navbar text color

```sql
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS nav_bg_color VARCHAR(50) DEFAULT 'rgba(255,255,255,1)',
ADD COLUMN IF NOT EXISTS nav_text_color VARCHAR(50) DEFAULT 'rgba(51,51,51,1)';
```

### 2. Code Changes

**File:** `imgui_website_designer.cpp`

**Changes Made:**

#### A. INSERT Query (Line ~1659)
**Before:**
```cpp
<< "accent_color, button_bg_color, button_text_color, "
<< "padding, text_align, ..."
```

**After:**
```cpp
<< "accent_color, button_bg_color, button_text_color, "
<< "nav_bg_color, nav_text_color, "  // ← ADDED
<< "padding, text_align, ..."
```

#### B. VALUES Part (Line ~1690)
**Before:**
```cpp
<< "'" << ColorToSQL(sec.button_text_color) << "', "
<< sec.padding << ", " << sec.text_align << ", "
```

**After:**
```cpp
<< "'" << ColorToSQL(sec.button_text_color) << "', "
<< "'" << ColorToSQL(sec.nav_bg_color) << "', "     // ← ADDED
<< "'" << ColorToSQL(sec.nav_text_color) << "', "   // ← ADDED
<< sec.padding << ", " << sec.text_align << ", "
```

#### C. SELECT/Load Part (Line ~2666)
**Before:**
```cpp
sec.button_text_color = PQgetisnull(result, row_num, 30) ? ... : SQLToColor(PQgetvalue(result, row_num, 30));

// For navbar sections, copy bg_color to nav_bg_color
if (type == SEC_NAVBAR) {
    sec.nav_bg_color = sec.bg_color;      // ← BUG: Not loading from DB
    sec.nav_text_color = sec.text_color;  // ← BUG: Not loading from DB
}

sec.padding = PQgetisnull(result, row_num, 31) ? ...
```

**After:**
```cpp
sec.button_text_color = PQgetisnull(result, row_num, 30) ? ... : SQLToColor(PQgetvalue(result, row_num, 30));
sec.nav_bg_color = PQgetisnull(result, row_num, 31) ? ... : SQLToColor(PQgetvalue(result, row_num, 31));     // ← FIXED
sec.nav_text_color = PQgetisnull(result, row_num, 32) ? ... : SQLToColor(PQgetvalue(result, row_num, 32));   // ← FIXED

sec.padding = PQgetisnull(result, row_num, 33) ? ...  // ← Index updated +2
```

#### D. All Column Indices Updated
All subsequent field indices incremented by +2 (because we added 2 new columns):
- padding: 31 → 33
- text_align: 32 → 34
- card_width: 33 → 35
- card_height: 34 → 36
- ... (all fields shifted by +2)
- logo_path: 56 → 58
- logo_size: 57 → 59
- brand_text_position: 58 → 60

---

## 🧪 Testing

### Test Navbar Color Save/Load:

1. **Create/Load Template**
2. **Select Navigation Section** (left panel)
3. **Change Colors** (right panel):
   - Nav Background: Change to blue/red/any color
   - Nav Text: Change to white/black/any color
4. **Save Template** (click Save button)
5. **Close App**
6. **Relaunch App**: `./imgui_website_designer`
7. **Load Same Template**
8. **Select Navigation Section**
9. **✅ Check:** Colors should match what you saved!

### Test Preview Mode:

1. **Design a template** with navbar + other sections
2. **Click "Preview" button** (top toolbar)
3. **Wait 10-30 seconds** for WebAssembly build
4. **✅ Check:** Browser should open with preview

If preview fails:
- Check terminal output for build errors
- Verify emscripten is installed: `em++ --version`
- Check `/tmp/imgui_website_preview/` for generated files

---

## 📋 Migration Steps (Already Done)

1. ✅ Run migration: `psql -d website_builder < add_navbar_colors.sql`
2. ✅ Rebuild app: `./build.sh`
3. ✅ Launch app: `./imgui_website_designer`

---

## 🎯 Result

**Before Fix:**
- Navbar colors: NOT SAVED ❌
- Preview: May work but navbar colors wrong ❌

**After Fix:**
- Navbar colors: SAVED & LOADED ✅
- Preview: Works with correct navbar colors ✅
- Logo: Upload + positioning working ✅

---

**App Status:** Running (PID: 10897) ✅
**Database:** Updated with new columns ✅
**Code:** Fixed save/load logic ✅

Test karo aur batao! 🚀
