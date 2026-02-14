# DEMO-123: Add Dark Mode Toggle to User Settings Page

**Project:** QualityQuest
**Type:** Story
**Status:** In Development
**Epic:** DEMO-100 — User Preferences Redesign
**Sprint:** Sprint 14
**Assignee:** Alex Chen (Frontend)
**Reporter:** Sarah Kim (Product Owner)
**Priority:** High
**Labels:** ui, accessibility, settings
**Feature Request:** DEMO-089

---

## Description

As a user, I want a dark mode toggle in my settings page so that I can switch between light and dark themes based on my preference.

The toggle should be available in **Settings > Appearance** and should persist across sessions. If the user has not set a preference, the app should follow the system-level theme (OS dark mode setting).

---

## Acceptance Criteria

1. A toggle switch appears in Settings > Appearance section
2. Clicking the toggle switches between light mode and dark mode immediately
3. The selected theme persists across browser sessions (stored in user profile)
4. Default behavior follows the OS/system theme preference when no user preference is set
5. All pages and components render correctly in both themes
6. Toggle state syncs across multiple open tabs in the same browser
7. Accessible: meets WCAG 2.1 AA contrast ratios in both themes

---

## Linked Tickets

| Ticket | Type | Summary |
|--------|------|---------|
| DEMO-100 | Epic | User Preferences Redesign |
| DEMO-089 | Feature Request | Customer request for dark mode support |
| DEMO-124 | Sub-task | UX Design: Dark mode color palette |
| DEMO-125 | Sub-task | API: User preference storage endpoint |
| DEMO-126 | Sub-task | Frontend: Theme switching component |

---

## Comments

**Sarah Kim** — _2 weeks ago_
> Customer feedback survey shows 68% of users want dark mode. This is our most requested feature this quarter.

**Alex Chen** — _1 week ago_
> Implementation plan: CSS custom properties for theme tokens, React context for state management, localStorage + API sync for persistence.

**Jordan Lee (UX)** — _1 week ago_
> Color palette finalized in Figma. Link in DEMO-124. We're using WCAG AA ratios for all text/background combinations.
