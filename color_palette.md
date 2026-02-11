# 🎨 Color Palette & Gradients

## Primary Brand Colors

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Teal Primary** | `#14B8A6` | Primary buttons, logo, brand elements |
| **Teal Hover** | `#0D9488` | Button hover states |
| **Teal Dark** | `#0F766E` | Active states |
| **Emerald Primary** | `#059669` | Gradient end, secondary brand |
| **Emerald Hover** | `#047857` | Hover gradient end |

## Neutral Colors (Grayscale)

| Color | Hex Code | Usage |
|-------|----------|-------|
| **White** | `#FFFFFF` | Card backgrounds, primary text on dark |
| **Gray Lightest** | `#F8FAFC` | Page backgrounds, subtle fills |
| **Gray Light** | `#F1F5F9` | Input backgrounds, secondary fills |
| **Gray Border** | `#E2E8F0` | Borders, dividers |
| **Gray Border Dark** | `#CBD5E1` | Stronger borders |
| **Gray Icon** | `#94A3B8` | Placeholder icons, disabled |
| **Gray Medium** | `#64748B` | Secondary text, captions |
| **Gray Dark** | `#475569` | Body text, icons |
| **Gray Darker** | `#334155` | Headings, important text |
| **Gray Darkest** | `#0F172A` | Primary text, dark backgrounds |
| **Primary Dark** | `#030213` | Alternative dark color |

## Accent Colors

### Blue
| Color | Hex Code | Usage |
|-------|----------|-------|
| **Blue Light** | `#EFF6FF` | Background gradient accent (login page) |

### Red (Destructive)
| Color | Hex Code | Usage |
|-------|----------|-------|
| **Red Light** | `#FEF2F2` | Error backgrounds |
| **Red Border** | `#FECACA` | Error borders |
| **Red Primary** | `#DC2626` | Error text, delete icons |
| **Red Dark** | `#B91C1C` | Error text dark |
| **Red Destructive** | `#D4183D` | Theme destructive color |

### Teal Accent
| Color | Hex Code | Usage |
|-------|----------|-------|
| **Teal Lightest** | `#F0FDFA` | Hover backgrounds |

### Emerald Accent
| Color | Hex Code | Usage |
|-------|----------|-------|
| **Emerald Lightest** | `#ECFDF5` | Hover backgrounds |

## Muted Colors (Theme System)

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Muted Background** | `#ECECF0` | Muted elements |
| **Muted Text** | `#717182` | Muted foreground text |
| **Input Background** | `#F3F3F5` | Form input backgrounds |
| **Switch Background** | `#CBCED4` | Toggle switch backgrounds |

---

## 🌈 Gradients

### 1. **Primary Brand Gradient** (Teal → Emerald)
```css
background: linear-gradient(to bottom right, #14B8A6, #059669);
```
**Tailwind:** `bg-gradient-to-br from-teal-500 to-emerald-600`

**Hover State:**
```css
background: linear-gradient(to bottom right, #0D9488, #047857);
```
**Tailwind:** `from-teal-600 to-emerald-700`

**Used in:**
- Login/Register page logo icon
- Primary action buttons (Login, Create Account, Save Secret)
- Dashboard floating action button (+)
- App logo across all pages
- Empty state create button

---

### 2. **Page Background Gradient** (Subtle Gray → Blue)
```css
background: linear-gradient(to bottom right, #F8FAFC, #F1F5F9, #EFF6FF);
```
**Tailwind:** `bg-gradient-to-br from-slate-50 via-slate-100 to-blue-50`

**Used in:**
- Login/Register page full background

---

### 3. **Avatar Gradient** (Dark Gray)
```css
background: linear-gradient(to bottom right, #334155, #0F172A);
```
**Tailwind:** `bg-gradient-to-br from-slate-700 to-slate-900`

**Used in:**
- Profile avatar button (Dashboard header)
- Large profile avatar (Profile page)

---

### 4. **Card Icon Gradient** (Neutral → Teal on Hover)

**Default State:**
```css
background: linear-gradient(to bottom right, #F1F5F9, #E2E8F0);
```
**Tailwind:** `bg-gradient-to-br from-slate-100 to-slate-200`

**Hover State:**
```css
background: linear-gradient(to bottom right, #F0FDFA, #ECFDF5);
```
**Tailwind:** `bg-gradient-to-br from-teal-50 to-emerald-50`

**Used in:**
- Dashboard secret list item icons

---

## 📱 Usage by Screen

### 🔐 **Login/Register Page**
- **Background:** `linear-gradient(to br, #F8FAFC, #F1F5F9, #EFF6FF)`
- **Logo Icon:** `linear-gradient(to br, #14B8A6, #059669)`
- **Card Background:** `#FFFFFF`
- **Input Background:** `#F8FAFC`
- **Input Border:** `#E2E8F0`
- **Input Focus Ring:** `#14B8A6`
- **Primary Button:** `linear-gradient(to r, #14B8A6, #059669)`
- **Primary Button Hover:** `linear-gradient(to r, #0D9488, #047857)`
- **Secondary Button Border:** `#CBD5E1`
- **Tab Active:** `#FFFFFF`
- **Tab Inactive:** `#64748B`
- **Icons:** `#94A3B8`
- **Labels:** `#334155`
- **Body Text:** `#475569`
- **Error Background:** `#FEF2F2`
- **Error Border:** `#FECACA`
- **Error Text:** `#B91C1C`
- **Link Color:** `#14B8A6`
- **Link Hover:** `#0F766E`

### 📊 **Dashboard**
- **Background:** `#F8FAFC`
- **Navbar Background:** `#FFFFFF`
- **Navbar Border:** `#E2E8F0`
- **Logo:** `linear-gradient(to br, #14B8A6, #059669)`
- **Search Background:** `#F1F5F9`
- **Search Focus:** `#FFFFFF`
- **Search Border Focus:** `#E2E8F0` + ring `#14B8A6`
- **Profile Avatar:** `linear-gradient(to br, #334155, #0F172A)`
- **Card Background:** `#FFFFFF`
- **Card Border:** `#E2E8F0`
- **Card Hover Border:** `#CBD5E1`
- **Card Icon Background:** `linear-gradient(to br, #F1F5F9, #E2E8F0)`
- **Card Icon Hover:** `linear-gradient(to br, #F0FDFA, #ECFDF5)`
- **Icon Color:** `#475569`
- **Icon Hover:** `#14B8A6`
- **Title Text:** `#0F172A`
- **Body Text:** `#64748B`
- **FAB Button:** `linear-gradient(to r, #14B8A6, #059669)`
- **FAB Hover:** `linear-gradient(to r, #0D9488, #047857)`

### 👤 **Profile Page**
- **Background:** `#F8FAFC`
- **Card Background:** `#FFFFFF`
- **Card Border:** `#E2E8F0`
- **Logo:** `linear-gradient(to br, #14B8A6, #059669)`
- **Avatar:** `linear-gradient(to br, #334155, #0F172A)`
- **Setting Icon Background:** `#F1F5F9`
- **Setting Icon Hover:** `#F0FDFA`
- **Icon Color:** `#475569`
- **Icon Hover:** `#14B8A6`
- **Delete Icon Background:** `#FEF2F2`
- **Delete Icon Hover:** `#FEE2E2`
- **Delete Icon Color:** `#DC2626`
- **Delete Text:** `#B91C1C`
- **Delete Border Hover:** `#FECACA`
- **Info Card Background:** `#F1F5F9`
- **Info Card Border:** `#E2E8F0`
- **Title Text:** `#0F172A`
- **Body Text:** `#475569`
- **Caption Text:** `#64748B`

### ✏️ **Create/Edit Secret**
- **Background:** `#F8FAFC`
- **Card Background:** `#FFFFFF`
- **Input Background:** `#F8FAFC`
- **Input Border:** `#E2E8F0`
- **Input Focus Ring:** `#14B8A6`
- **Save Button:** `linear-gradient(to r, #14B8A6, #059669)`
- **Save Button Hover:** `linear-gradient(to r, #0D9488, #047857)`
- **Cancel Button Border:** `#CBD5E1`
- **Cancel Button Hover:** `#F8FAFC`
- **Label Text:** `#334155`
- **Helper Text:** `#64748B`

---

## 🎯 Shadow Colors

| Shadow | Color with Opacity | Usage |
|--------|-------------------|-------|
| Card Shadow | `#E2E8F0` at 50% | `shadow-slate-200/50` |
| Card Hover | `#E2E8F0` at 100% | `shadow-slate-200` |
| Button Shadow | `#14B8A6` at 25% | `shadow-teal-500/25` |
| Button Hover Shadow | `#14B8A6` at 30% | `shadow-teal-500/30` |
| FAB Shadow | `#14B8A6` at 40% | `shadow-teal-500/40` |

---

## 🎨 Color Variables (CSS Custom Properties)

### Light Theme
```css
--background: #FFFFFF
--foreground: #030213
--primary: #030213
--destructive: #D4183D
--muted: #ECECF0
--muted-foreground: #717182
--input-background: #F3F3F5
--border: rgba(0, 0, 0, 0.1)
--switch-background: #CBCED4
```

### Dark Theme
```css
--background: #030213
--foreground: #FAFAFA
--primary: #FAFAFA
```

---

## 📝 Notes

- **Border Opacity:** Main borders use `rgba(0, 0, 0, 0.1)` for subtle separation
- **Primary Gradient Direction:** Most gradients use `to-br` (bottom-right) or `to-r` (right)
- **Hover Transitions:** All interactive elements use 600/700 weight colors for hover states
- **Focus Rings:** All focusable inputs use teal-500 (`#14B8A6`) with 50% opacity
- **Icon States:** Icons transition from gray (`#475569`) to teal (`#14B8A6`) on hover
