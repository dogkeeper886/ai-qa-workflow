# Demo Review Reference

## What This Phase Does

| Phase | Action | Output |
|-------|--------|--------|
| 1. Parse | Read `Demo_Showcase_Content.md` | Extract navigation paths, UI labels, field names |
| 2. Setup | Launch browser, login to test environment | Authenticated session, `demo/screenshots/` created |
| 3. Verify | Walk the UI following Slide 4 navigation | Compare labels/paths against documented text |
| 4. Capture | Take screenshots at key demo points | `demo/screenshots/NN_Description.png` |
| 5. Update | Fix content file in-place (Slides 1-4 only) | Corrected `Demo_Showcase_Content.md` |
| 6. Expand | Replace Demo slide with per-step slides | Expanded `Demo_Showcase_Content.md` |

---

## Phase 1: Parse Demo Content

1. Read `[PROJECT]/demo/Demo_Showcase_Content.md`
2. Extract verification targets from Slides 4 and 5:
   - Navigation path (e.g., "Navigate to Network Control > Service Catalog")
   - UI labels and field names
   - Behavioral claims
   - Expected table/list values

3. Build a checklist:

   | # | Type | Claim | Source Slide |
   |---|------|-------|--------------|
   | 1 | Navigation | "Network Control > Service Catalog" | Slide 4 |
   | 2 | Label | "IP Address or FQDN" | Slide 4 |

---

## Phase 2: Setup Browser

1. Read credentials from `config/env-staging.txt`
2. Launch browser and resize: `playwright-mcp:browser_resize: 1280x900`
3. Navigate to login page and authenticate
4. Verify login success
5. Create `demo/screenshots/` folder if it doesn't exist

---

## Phase 3: Verify UI Content

For each navigation step in Slide 4:

1. Navigate to the documented path
2. Compare UI elements against documented claims:
   - Menu item names match?
   - Field labels match?
   - Button text matches?

3. Record findings:

   | # | Claim | Actual UI | Match? | Action |
   |---|-------|-----------|--------|--------|
   | 1 | Menu: "Service Catalog" | "Service Catalog" | Yes | None |
   | 2 | Label: "IP Address or FQDN" | "IP Address / FQDN" | No | Update content |

---

## Phase 4: Capture Screenshots

1. Name screenshots with numbered prefix:
   - `01_Description.png` - first key screen
   - `02_Description.png` - second key screen

2. Take screenshots using `playwright-mcp:browser_take_screenshot`:
   ```
   filename: demo/screenshots/NN_Description.png
   type: png
   ```

3. Capture at: starting navigation page, configuration form, key fields, result after saving, any tables showing new data

---

## Phase 5: Update Slides 1-4

Fix any mismatches found in Phase 3 for Slides 1-4 ONLY:
- Correct UI labels in Slide 4 bullets and script
- Fix navigation paths if menu names differ
- Update field names, button text, default values
- Save the updated `demo/Demo_Showcase_Content.md`

---

## Phase 6: Expand Demo Slide

Replace Slide 5 (Demo) and Slide 6 (Questions) with per-step slides:

1. Remove existing `## Slide 5: Demo` section
2. Remove existing `## Slide 6: Questions` section
3. Insert per-step demo slides starting at Slide 5

   **Image format** (step has screenshot):
   ```markdown
   ## Slide N: [Step Action Title]
   **Title:** [Step Action Title]
   **Content:** ![alt text](screenshots/NN_Description.png)

   **Script:**
   "[Presenter speech for this step]"
   ```

4. Add Questions slide as the last numbered slide
5. Append Review Metadata section (uses `## Review Metadata` heading — PPT parser ignores it)

---

## Output Summary

Report to the user:
1. Verification results: claims matched vs. needed correction
2. Screenshots captured: list of files in `demo/screenshots/`
3. Content changes: summary of what was corrected
4. Slide count: Original (6) vs. expanded (N)
