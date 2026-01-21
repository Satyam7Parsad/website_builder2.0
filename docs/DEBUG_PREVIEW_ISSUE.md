# 🔍 Debug Preview Issue - Step by Step

## Problem:
- User loads ANY template
- Clicks Preview
- Always sees Nike template (wrong!)
- Scroll doesn't work

---

## ✅ Debug Mode Enabled

I've added detailed logging to track exactly what's happening:

**App Status:**
- ✅ Rebuilt with debug output
- ✅ Running fresh (old preview cache deleted)
- ✅ Logs going to `/tmp/imgui_debug.log`

---

## 🧪 TEST PROCEDURE - Follow Exactly:

### Step 1: Load a Template (NOT Nike)

1. App is already running
2. Click **"Load Template"** button (top left toolbar)
3. In the popup, select **ANY template EXCEPT Nike**
   - For example: Select "Apple" or any other template
4. Wait for template to load
5. **Check left panel** - you should see sections from that template

### Step 2: Click Preview

1. Once template is loaded (sections showing in left panel)
2. Click **"Preview"** button (top toolbar)
3. Wait 10-30 seconds for build
4. Browser will open

### Step 3: Report Back

**Tell me:**

A. **Which template did you select?** (e.g., "Apple", "imported_apple_com_xxxx", etc.)

B. **What sections showed in left panel after loading?**
   - Example: "Navigation, Hero, Features, Contact"

C. **Which template showed in the browser preview?**
   - Was it Nike or the one you selected?

D. **Did scroll work?**
   - Try: Trackpad two-finger scroll
   - Try: Click once, then scroll

---

## 📋 I Will Check The Logs

While you test, I'll check `/tmp/imgui_debug.log` which will show:

```
========================================
[LoadTemplate] SUCCESS: Template 'Apple' loaded from database
[LoadTemplate] Loaded 5 sections:
  1. Navigation - 'Brand'
  2. Hero - 'Welcome'
  3. Features - 'Our Services'
  4. Team - 'Meet the Team'
  5. Contact - 'Get In Touch'
========================================

========================================
[Preview] Starting preview with 5 sections
[Preview] Sections being previewed:
  1. Navigation - 'Brand'
  2. Hero - 'Welcome'
  3. Features - 'Our Services'
  4. Team - 'Meet the Team'
  5. Contact - 'Get In Touch'
========================================
```

This will tell us:
- ✅ Is the template actually loading?
- ✅ Are the sections being updated?
- ✅ Is Preview using the correct sections?

---

## 🎯 Expected vs. Actual

### If Working Correctly:
```
You load: Apple template
Left panel shows: Apple sections
Preview shows: Apple template ✅
```

### If Bug Exists:
```
You load: Apple template
Left panel shows: Apple sections
Preview shows: Nike template ❌ BUG!
```

---

## ⚠️ Important Notes:

1. **Make SURE you see sections in left panel before clicking Preview**
   - If left panel is empty, template didn't load

2. **Wait for full build (10-30 seconds)**
   - Don't refresh browser until build completes

3. **Try clicking on the preview page BEFORE scrolling**
   - Canvas needs focus for scroll events

---

## 🚀 Ready to Test!

**GO NOW:**
1. Load a template (NOT Nike!)
2. Check left panel has sections
3. Click Preview
4. Report back with template name and what you see

I'll check the logs and tell you exactly what happened! 🔍
