# Video Script: AI QA Workflow — From Monolithic to Orchestrated

**Total target:** 13-14 minutes (~2,200 spoken words)
**Recording notes:** Speak at a natural pace. Pause briefly between sections. Screen share your IDE throughout.

---

## Section 1: INTRO — The Problem (2 min)

> I built slash commands for AI coding agents to do QA work. Trace Jira tickets, plan tests, write test cases, push them to TestLink, even generate demo presentations. It worked great at first.

> But as I added more rules — formatting, edge cases, decision trees — the command files got really long. One day, I noticed the AI started missing steps. It skipped a section in a flow chart. It gave me test cases where the title said one thing but the objective said something else. Steps were partly correct, partly wrong.

> And it wasn't just one command. This happened with Jira tracing, test planning, test case design. Anywhere I had a long file, the AI would lose track of what to do halfway through.

> So I made a big change. Let me show you what I started with.

**[SHOW: GitHub repo. Navigate to `demo/v1_commands/` folder.]**

---

## Section 2: THE OLD WAY (2-3 min)

> In v1.0, I had three main command files.

**[SHOW: Open `demo/v1_commands/jira-trace.md`. Scroll through it.]**

> First, the Jira trace command. 209 lines. It fetched tickets, followed links, pulled in Confluence docs, and organized everything — all in one file. Not the worst, but still a lot of context for the AI to hold at once.

**[SHOW: Open `demo/v1_commands/test-planning-checklist.md`. Scroll slowly through it.]**

> Next, the test planning command. 1,271 lines. This is the big one. One file tried to handle everything — detect if you're testing a new feature, a bug fix, or an enhancement. Gather info from Jira and Confluence. Then create the full test plan. All different workflows mixed together. The AI had to read the whole thing and figure out which part to follow.

**[SHOW: Scroll to the bottom to show the length.]**

> And the third one.

**[SHOW: Open `demo/v1_commands/test-case-design-checklist.md`.]**

> 814 lines for creating test cases. Features, bug fixes, enhancements — all in one file. Plus HTML formatting rules for TestLink, quality checklists, templates.

> Three files, over 2,200 lines total. Too much context for one command. The AI would start strong at the top, but by the time it got halfway through, it started mixing things up. A feature workflow would bleed into a bug fix workflow. Steps would reference the wrong section. That's the problem with monolithic instructions.

---

## Section 3: THE NEW WAY (5-6 min)

### 3A: The Pattern (1 min)

> So I broke them apart. And I didn't just split the files randomly. I used a pattern: detect, route, execute. A short entry-point command reads your project, figures out what kind of work it is, and routes you to the right specialist command. Each specialist does exactly one job. And every command ends with a clear next step — here's what to run next.

> I ended up with three styles of this pattern. Let me show you each one.

### 3B: Jira Trace Pipeline (1 min)

**[SHOW: Open `commands/jira/` directory listing — 6 files.]**

> First, the Jira trace pipeline. The old `jira-trace.md` was 209 lines doing everything. Now I have `/jr-trace` — 82 lines. It's the entry point. It calls three sub-commands in sequence: fetch, structure, docs.

**[SHOW: Open `commands/jira/jr-trace.md`. Point to the routing logic.]**

> `jr-trace-fetch` pulls the ticket and all linked issues. `jr-trace-structure` organizes what it found into project files. `jr-trace-docs` fetches related Confluence pages. Each one does its job and passes the result to the next. That's a sequential pipeline.

> Compare that to the old 209-line monolith. Same result, but now each piece is small enough that the AI doesn't lose track.

### 3C: Test Workflow Router (2 min)

**[SHOW: Open `commands/test-workflow/` directory listing — 13 files.]**

> Second pattern: fan-out routing. This is where the two big monolithic files became 13 focused commands.

**[SHOW: Open `commands/test-workflow/tw-plan-init.md` — scroll to show it's ~150 lines.]**

> `tw-plan-init`. 150 lines. This is the starting point for test planning. It reads your project files, detects what type of testing you need — new feature, bug fix, or enhancement — and tells you which command to run next. That's all it does. One job.

**[SHOW: Scroll to the detection logic and the workflow diagram at the bottom.]**

> See this at the bottom? A workflow diagram showing exactly where you are and where to go next. Every command has one of these.

**[SHOW: Open `commands/test-workflow/tw-plan-feature.md` — scroll to show ~200 lines.]**

> `tw-plan-feature`. 200 lines. Feature test planning only. Nothing about bug fixes. Nothing about enhancements. Just features.

**[SHOW: Open `commands/test-workflow/tw-plan-review.md` — scroll to the coverage matrix template.]**

> Then `tw-plan-review`. 359 lines — the longest file in the project, and it's still way under the old 1,271. This is a quality gate. It reads your test plan, builds a coverage matrix, checks for gaps. This didn't exist in v1.0. There was no review step. You just went straight from planning to writing test cases and hoped the plan was good.

**[SHOW: Open `commands/test-workflow/tw-case-init.md` briefly.]**

> Same pattern for test cases. `tw-case-init` reads the test plan, detects the type, and routes you to the right command. Feature? Run `tw-case-feature`. Bug fix? Run `tw-case-bugfix`.

**[SHOW: Open `commands/test-workflow/tw-case-review.md` briefly.]**

> And another quality gate. `tw-case-review` checks every test case: Are the objectives clear? Are the steps specific? Are the expected results measurable?

### 3D: TestLink Sync and Demo Pipeline (1 min)

**[SHOW: Open `commands/testlink/tl-sync.md`.]**

> Third pattern: smart diff. `/tl-sync` doesn't just push everything to TestLink. It compares your local test cases against what's already there. If a case exists and hasn't changed, it skips it. If it's new, it creates it. If it changed, it updates it. Think of it like `git diff` but for test management.

**[SHOW: Open `commands/project/` directory listing — 8 files.]**

> And there's a similar orchestration in the project commands. `/pm-demo-content` generates demo presentation content, then routes to `/pm-demo-review` for quality checks, `/pm-demo-ppt` for slide outlines, and `/pm-demo-email` for announcements. Four commands working together instead of one giant file.

### 3E: Pattern Summary (30 sec)

> So, three patterns. Sequential pipeline — `/jr-trace` chains commands in order. Fan-out router — `/tw-plan-init` detects context and picks the right specialist. Smart diff — `/tl-sync` compares state and applies only what changed. The common thread: small commands, one job each, always a clear next step.

---

## Section 4: DEMO — Example Output (3-4 min)

> Let me show you what this actually looks like when you run it. I set up a demo project — a Jira ticket for adding a dark mode toggle to a settings page. In a real workflow, `/jr-trace` would have created these project files from Jira. For the demo, I wrote them by hand.

**[SHOW: Open `demo/00_Main_Task_DEMO-123.md`. Highlight the ticket type (Story), the acceptance criteria.]**

> Simple feature. Toggle switch, dark and light themes, persists across sessions, follows OS preference. There's also a High Level Design doc.

**[SHOW: Open `demo/confluence/HLD_Dark_Mode_Toggle.md` briefly. Show the data flow section.]**

> Now let's run through the workflow.

**[SHOW: Open `demo/examples/01_tw-plan-init_output.md`.]**

> Step 1. `tw-plan-init`. It read the ticket, saw it's a Story under an Epic, found the HLD document, and said: "Type A, New Feature. Run `tw-plan-feature` next." High confidence. That's it. Short, clear, actionable.

**[SHOW: Open `demo/examples/02_tw-plan-feature_output.md`. Scroll through the test plan.]**

> Step 2. `tw-plan-feature`. It created a full test plan with 6 scenarios and 28 estimated test cases. Toggle functionality, theme rendering, persistence, system preference detection, cross-tab sync, and accessibility.

**[SHOW: Point to the test scenario table.]**

> Each row is a test suite. TS-01 through TS-06. Focused topics, estimated case counts, specific test activities. And at the bottom — "Next step: run `tw-plan-review`."

**[SHOW: Open `demo/examples/03_tw-plan-review_output.md`. Scroll to the coverage matrix.]**

> Step 3. `tw-plan-review`. The first quality gate. It built a coverage matrix mapping scenarios to aspects like UI, data flow, error handling, and accessibility. It found two minor gaps and said: status READY.

**[SHOW: Open `demo/examples/04_tw-case-feature_output.md`. Scroll through TC-01 and TC-02.]**

> Step 4. `tw-case-feature`. Actual test cases. Here's TS-01 — toggle basic functionality. Five test cases. TC-01: "Toggle Dark Mode On." The steps say exactly what to click, exactly what should change — background goes from white to dark, transition under 200ms.

**[SHOW: Point to TC-05 "Rapid Toggle".]**

> And edge cases — TC-05, rapid toggling. Click the toggle 5 times quickly, make sure nothing breaks. These are the kinds of test cases that were getting lost in the 1,200-line file.

**[SHOW: Open `demo/examples/05_tw-case-review_output.md`.]**

> Step 5. `tw-case-review`. The second quality gate. All 28 test cases across 6 scenarios — no vague actions, no missing preconditions, no terminology issues. Status: Ready for TestLink. From here you'd run `/tl-sync` to push everything, then `/pm-demo-content` to generate a presentation.

---

## Section 5: THE FULL PICTURE (2 min)

**[SHOW: Comparison table — can use a slide or markdown preview.]**

> Let me put this side by side.

| | v1.0 | v2.0 |
|---|---|---|
| Command files | 3 monolithic | 53 focused |
| Command families | 1 folder | 6 folders |
| Longest file | 1,271 lines | 359 lines |
| Quality gates | None | 2 review commands |
| Next step hints | None | Every command |
| Orchestration | None | 3 patterns |

> Three files became fifty-three. One folder became six. The longest file went from 1,271 lines down to 359. We added quality gates that didn't exist before. And every command tells the AI exactly what to do next.

> Here's the full flow. You start with `/jr-trace` to gather requirements from Jira. Then `/tw-plan-init` detects what kind of testing you need and routes to the right planner. `/tw-plan-review` checks the plan. `/tw-case-init` routes to the right case designer. `/tw-case-review` checks the cases. `/tl-sync` pushes everything to TestLink. Six steps, each one small and focused.

> The lesson is simple. When your AI instructions get too long, it starts missing things. Break them into smaller pieces. One job per command. Give it a pattern to follow — detect, route, execute. And always tell it what comes next.

> All 53 commands are open source. Link in the description. You can install them with `make install` and start using them with Claude Code or Cursor today.

> Thanks for watching.

---

## Production Notes

**Estimated spoken time:** ~13-14 minutes at natural pace
**Word count:** ~2,100 words (spoken portions)

**Screen share order:**
1. GitHub repo — `demo/v1_commands/` folder
2. `demo/v1_commands/jira-trace.md` (scroll through)
3. `demo/v1_commands/test-planning-checklist.md` (scroll through)
4. `demo/v1_commands/test-case-design-checklist.md` (scroll through)
5. `commands/jira/` directory listing, then `jr-trace.md`
6. `commands/test-workflow/` directory listing
7. v2.0 files: `tw-plan-init.md`, `tw-plan-feature.md`, `tw-plan-review.md`, `tw-case-init.md`, `tw-case-review.md`
8. `commands/testlink/tl-sync.md`
9. `commands/project/` directory listing
10. Demo project: `00_Main_Task_DEMO-123.md`, `confluence/HLD_Dark_Mode_Toggle.md`
11. Example outputs: 01 through 05 in order
12. Comparison table

**v1.0 files located at:**
```
demo/v1_commands/jira-trace.md                (209 lines)
demo/v1_commands/test-planning-checklist.md   (1,271 lines)
demo/v1_commands/test-case-design-checklist.md (814 lines)
```
