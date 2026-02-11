# Video Script: AI QA Workflow — v1.0 vs v2.0

**Total target:** 10-15 minutes (~1,500-2,200 words)
**Recording notes:** Speak at a natural pace. Pause briefly between sections. Screen share your IDE throughout.

---

## Section 1: INTRO — The Problem (2 min)

> I built slash commands for AI coding agents to do QA work. Trace Jira tickets, plan tests, write test cases, push them to TestLink. It worked great at first.

> But as I added more rules — formatting, edge cases, decision trees — the command files got really long. One day, I noticed the AI started missing steps. It skipped a section in a flow chart. It gave me test cases where the title said one thing but the objective said something else. Steps were partly correct, partly wrong.

> I looked at the command file again. Over 1,200 lines. The AI was losing track of what to do halfway through. So I made a big change.

**[SHOW: GitHub repo with v1.0 and v2.0 tags visible. Click on v1.0 tag.]**

---

## Section 2: THE OLD WAY — v1.0 (2-3 min)

> In v1.0, I had two main command files for test work.

**[SHOW: Open `commands/qa/test-planning-checklist.md` from v1.0 tag. Scroll slowly through it.]**

> This is the test planning command. 1,271 lines. One file tried to handle everything — detect if you're testing a new feature, a bug fix, or an enhancement. Gather info from Jira and Confluence. Then create the full test plan. All different workflows mixed together. The AI had to read the whole thing and figure out which part to follow.

**[SHOW: Scroll to bottom to show the length. Point out different sections jumbled together.]**

> And here's the second one.

**[SHOW: Open `commands/qa/test-case-design-checklist.md` from v1.0 tag.]**

> 814 lines for creating test cases. Features, bug fixes, enhancements — all in one file. Plus HTML formatting rules for TestLink, quality checklists, templates. Everything in one place.

> Two files, over 2,000 lines total. Too much context for one command. The AI would start strong at the top, but by the time it got halfway through, it started mixing things up. A feature workflow would bleed into a bug fix workflow. Steps would reference the wrong section. That's the problem with monolithic instructions.

---

## Section 3: THE NEW WAY — v2.0 (4-5 min)

> So I broke them apart. Small files, each doing one thing. And every command ends with a clear next step — here's what to run next.

> Let me show you the new structure.

**[SHOW: `commands/test-workflow/` directory listing — 13 files.]**

> 13 files instead of 2. Let me walk through the main ones.

**[SHOW: Open `tw-plan-init.md` — scroll to show it's ~150 lines.]**

> First, `tw-plan-init`. 150 lines. This is the starting point. It reads your project files, detects what type of testing you need — is it a new feature, a bug fix, or an enhancement? — and tells you which command to run next. That's all it does. One job.

**[SHOW: Scroll to the detection logic and the workflow diagram at the bottom.]**

> See this at the bottom? A workflow diagram showing exactly where you are and where to go next. Every command has one of these.

**[SHOW: Open `tw-plan-feature.md` — scroll to show ~200 lines.]**

> Next, `tw-plan-feature`. 200 lines. Feature test planning only. It looks for design docs in your Confluence folder, creates 5 to 8 test scenarios. There's nothing about bug fixes in here. Nothing about enhancements. Just features.

**[SHOW: Open `tw-plan-bugfix.md` briefly.]**

> Bug fix? Different command. `tw-plan-bugfix`. 300 lines. Smaller scope — 2 to 4 scenarios. Focused on reproducing the bug and making sure it doesn't come back.

**[SHOW: Open `tw-plan-review.md` — scroll to show the coverage matrix template.]**

> Now here's something new. `tw-plan-review`. 359 lines. This is a quality gate. It reads your test plan, builds a coverage matrix, checks for gaps and overlaps. This didn't exist in v1.0. There was no review step. You just went straight from planning to writing test cases and hoped the plan was good.

**[SHOW: Open `tw-case-init.md` briefly.]**

> Same pattern for test cases. `tw-case-init` reads the test plan, detects the type, and routes you to the right command. Feature? Run `tw-case-feature`. Bug fix? Run `tw-case-bugfix`.

**[SHOW: Open `tw-case-review.md` briefly.]**

> And another quality gate. `tw-case-review` checks every test case: Are the objectives clear? Are the steps specific — not vague like "enter data" but specific like "enter test@example.com in the Email field"? Are the expected results measurable? This catches exactly the problems I was seeing in v1.0.

> Let me highlight the key pattern.

**[SHOW: Scroll to the NEXT STEP section and workflow diagram in `tw-plan-feature.md`.]**

> Every command ends with this. "Next step: run this command." Plus a diagram showing the full workflow and where you are in it. The AI always knows what just happened and what comes next.

---

## Section 4: DEMO — Example Output (4-5 min)

> Let me show you what this actually looks like when you run it. I set up a demo project — a Jira ticket for adding a dark mode toggle to a settings page.

**[SHOW: Open `demo/00_Main_Task_DEMO-123.md`. Highlight the ticket type (Story), the acceptance criteria.]**

> Simple feature. Toggle switch, dark and light themes, persists across sessions, follows OS preference. There's also a High Level Design doc.

**[SHOW: Open `demo/confluence/HLD_Dark_Mode_Toggle.md` briefly. Show the data flow section.]**

> Now let's run through the workflow.

**[SHOW: Open `demo/examples/01_tw-plan-init_output.md`.]**

> Step 1. `tw-plan-init`. It read the ticket, saw it's a Story under an Epic, found the HLD document, and said: "Type A, New Feature. Run `tw-plan-feature` next." High confidence. That's it. Short, clear, actionable.

**[SHOW: Open `demo/examples/02_tw-plan-feature_output.md`. Scroll through the test plan.]**

> Step 2. `tw-plan-feature`. It created a full test plan with 6 scenarios and 28 estimated test cases. Toggle functionality, theme rendering, persistence, system preference detection, cross-tab sync, and accessibility. Each scenario has a clear focus and a list of test activities.

**[SHOW: Point to the test scenario table (§ 4.4).]**

> Look at this table. Each row is a test suite. TS-01 through TS-06. Focused topics, estimated case counts, specific test activities. And at the bottom — "Next step: run `tw-plan-review`."

**[SHOW: Open `demo/examples/03_tw-plan-review_output.md`. Scroll to the coverage matrix.]**

> Step 3. `tw-plan-review`. This is the first quality gate. It built a coverage matrix — you can see which scenario covers which aspect. UI configuration, data flow, error handling, accessibility — all mapped out. It found two minor gaps: no cross-browser specific tests and no page load performance test. And it said: status READY. Good to proceed.

**[SHOW: Point to the coverage matrix ASCII table and the modular design diagram.]**

> These diagrams also help you see the structure. Core feature at the top, integration and accessibility branching off. This gives you confidence the plan is solid before you spend time writing detailed test cases.

**[SHOW: Open `demo/examples/04_tw-case-feature_output.md`. Scroll through TC-01 and TC-02.]**

> Step 4. `tw-case-feature`. Now we're writing actual test cases. Here's TS-01 — toggle basic functionality. Five test cases. Look at TC-01: "Toggle Dark Mode On." The objective is specific. The steps say exactly what to click, exactly what should change — background goes from white to dark, text goes from dark to light, transition under 200ms.

**[SHOW: Point to the step table in TC-01, then scroll to TC-05 "Rapid Toggle".]**

> And here's an edge case — TC-05, rapid toggling. Click the toggle 5 times quickly, make sure nothing breaks. These are the kinds of test cases that were getting lost in the 1,200-line file.

**[SHOW: Open `demo/examples/05_tw-case-review_output.md`.]**

> Step 5. `tw-case-review`. The second quality gate. It checked all 28 test cases across 6 scenarios. No vague actions, no vague expected results, no missing preconditions, no terminology inconsistencies. Status: Ready for TestLink.

**[SHOW: Point to the completeness check table — all scenarios show "OK".]**

> Every scenario has the right number of test cases. All pass quality checks. From here you'd run `tl-sync` to push everything to TestLink.

---

## Section 5: COMPARISON & WRAP UP (1-2 min)

**[SHOW: Comparison table — can use a slide or markdown preview.]**

> Let me put this side by side.

| | v1.0 | v2.0 |
|---|---|---|
| Files | 2 monolithic | 13 focused |
| Longest file | 1,271 lines | 359 lines |
| Quality checks | None | 2 review gates |
| Next step hints | None | Every command |

> Two files became thirteen. The longest file went from 1,271 lines down to 359. We added two quality gates that didn't exist before. And every command tells the AI exactly what to do next.

> The lesson is simple. When your AI instructions get too long, it starts missing things. Break them into smaller pieces. One job per command. And always tell it what comes next.

> All of these commands are open source. Link in the description. You can install them with `make install` and start using them with Claude Code or Cursor today.

> Thanks for watching.

---

## Production Notes

**Estimated spoken time:** ~12-13 minutes at natural pace
**Word count:** ~1,700 words (spoken portions)

**Screen share order:**
1. GitHub repo — v1.0 tag
2. v1.0 `test-planning-checklist.md` (scroll through)
3. v1.0 `test-case-design-checklist.md` (scroll through)
4. v2.0 `commands/test-workflow/` directory listing
5. v2.0 files: `tw-plan-init.md`, `tw-plan-feature.md`, `tw-plan-bugfix.md`, `tw-plan-review.md`, `tw-case-init.md`, `tw-case-review.md`
6. Demo pseudo project: `00_Main_Task_DEMO-123.md`, `HLD_Dark_Mode_Toggle.md`
7. Example outputs: 01 through 05 in order
8. Comparison table

**v1.0 files accessible via:**
```bash
git show v1.0:commands/qa/test-planning-checklist.md
git show v1.0:commands/qa/test-case-design-checklist.md
```
