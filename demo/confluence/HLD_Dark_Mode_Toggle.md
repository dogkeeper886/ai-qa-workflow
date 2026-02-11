# High Level Design: Dark Mode Toggle

**Document:** HLD-2024-047
**Author:** Alex Chen
**Status:** Approved
**Last Updated:** 2024-11-15

---

## 1. Overview

Add a dark mode toggle to the user settings page. Users can switch between light and dark themes. The preference is stored server-side in the user profile and cached client-side in localStorage for fast loading.

## 2. UI Components

### 2.1 Settings Page

- **Location:** Settings > Appearance
- **Component:** Toggle switch with label "Dark Mode"
- **States:** ON (dark theme) / OFF (light theme)
- **Default:** Follows system preference (`prefers-color-scheme` media query)

### 2.2 Theme Application

- CSS custom properties define all color tokens (`--bg-primary`, `--text-primary`, etc.)
- Theme class applied to `<body>`: `theme-light` or `theme-dark`
- Transition: 200ms ease for smooth switching

## 3. Data Flow

```
User clicks toggle
    → React state updates (ThemeContext)
    → CSS class on <body> changes
    → localStorage updated immediately
    → API call: PUT /api/user/preferences { theme: "dark" | "light" }
    → Server stores in user_preferences table
```

### 3.1 Page Load Sequence

```
1. Check localStorage for cached theme preference
2. Apply cached theme immediately (prevents flash)
3. Fetch user profile from API
4. If API preference differs from cache → update to API value
5. If no preference set → read OS prefers-color-scheme → apply
```

## 4. API Endpoint

**PUT** `/api/user/preferences`

```json
{
  "theme": "dark" | "light" | "system"
}
```

**Response:** `200 OK` with updated preferences object.

## 5. Scope

### In Scope

- Toggle switch in Settings > Appearance
- Light and dark theme CSS tokens
- Persistence via API + localStorage
- System preference detection
- Cross-tab sync via `storage` event listener
- WCAG 2.1 AA contrast compliance

### Out of Scope

- Custom color themes (future phase)
- Scheduled theme switching (e.g., dark at night)
- Per-page theme overrides

## 6. Non-Functional Requirements

- Theme switch must complete in under 200ms
- No visible flash of wrong theme on page load
- Works in Chrome, Firefox, Safari, Edge (latest 2 versions)
