# PPTX Generation Reference

## Prerequisites

- Slide-content markdown exists in `demo/Demo_Showcase_Content.md`
- Python 3 with `python-pptx` package: `pip3 install python-pptx`
- Optional: `Pillow` package for image embedding: `pip3 install Pillow`
- Corporate template: `docs/templates/Demo_Template.pptx`

---

## Running the Converter

**Always use `--template` for company branding:**

```bash
python3 scripts/md_to_pptx.py [PROJECT_PATH]/demo/Demo_Showcase_Content.md \
  --template docs/templates/Demo_Template.pptx
```

**Check dependencies first:**
```bash
python3 -c "import pptx; print('python-pptx OK')"
```

---

## What the Script Does

`scripts/md_to_pptx.py` handles all conversion logic:

- **Parses markdown** into slide data (title, subtitle, bullets, content, images)
- **Auto-detects slide types**: title, bullet, image, closing, placeholder
- **Uses template layouts**: maps slide types to template layouts via JSON config
- **Embeds images**: resolves `![alt](file.png)` relative to markdown file
- **Adds speaker notes**: from inline `**Script:**` blocks
- **Strips markdown formatting**: removes `**bold**` markers from slide text
- **Names output file** from the `# heading` in the markdown

---

## Slide Type Detection

| Type | Detection | Template Layout |
|------|-----------|-----------------|
| **Title** | Has subtitle, no bullets | Config `title` layout |
| **Bullet** | Has `**Bullets:**` with `- ` items | Config `bullet` layout |
| **Image** | Content has `![alt](file.png)` | Config `image_full` or `image_side` |
| **Closing** | Title contains "Questions" or "Thank You" | Config `closing` layout |
| **Placeholder** | Content has `[placeholder text]` | Config `bullet` layout |

---

## Template Config System

When `--template` is used, the script loads a JSON config from alongside the template.

**Config file:** Same name as template with `.json` extension

```json
{
  "layouts": {
    "title": "8_Title Colorful Ribbon",
    "bullet": "Picture with Blue Below",
    "image_side": "Picture with Blue Ribbon",
    "image_full": "Thin Blue",
    "closing": "Blue Divider"
  },
  "placeholders": {
    "title": { "title": 0, "subtitle": 1, "date": 13 },
    "bullet": { "title": 0, "content": 1 },
    "image_side": { "title": 0, "text": 2, "picture": 1 },
    "image_full": { "title": 0 },
    "closing": { "content": 14 }
  }
}
```

---

## Output

- `.pptx` file saved in `demo/` folder, named from the `# heading`
- **Bullets** go on slides, **Script** goes into speaker notes pane
- Corporate theme applied with `--template`

---

## Reporting Results

After generation, report:
- Output PPTX file path
- Number of slides generated
- Slide type breakdown (title, bullet, image, closing, placeholder)
- Whether any `[placeholder]` text remains (flag these)

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| `python-pptx` not installed | `pip3 install python-pptx` |
| No slides in output | Check markdown follows `## Slide N:` format |
| Image not found | Ensure image file is next to the markdown file |
| Speaker notes missing | Check `**Script:**` blocks exist |
| Can't edit design in PowerPoint | Forgot `--template` flag — regenerate with `--template` |
| Wrong layouts used | Edit `docs/templates/Demo_Template.json` |
