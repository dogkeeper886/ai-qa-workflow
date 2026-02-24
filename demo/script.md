# Video Script: AI QA Workflow v2.0 — Major Update

**Recording notes:** Speak at a natural pace. Pause briefly between sections. Screen share your IDE throughout.

---

## Section 1: INTRO — What Is AI QA Workflow (1 min)

> Welcome to the channel. Today I'm going to show you the major update about AI QA Workflow.

> AI QA Workflow is an open-source toolkit that connects AI coding agents — like Claude Code — with test management systems. It uses slash commands and MCP integrations to automate the full QA lifecycle: tracing requirements in Jira, planning tests, designing test cases, syncing them to TestLink, and even generating demo presentations — all driven by markdown files that AI agents can follow.

> In this video, I'll show you how to use it.

---

## Section 2: THE PROBLEM (1-2 min)

> I built slash commands for AI coding agents to do QA work. It worked pretty good at first. But as I added more rules — formatting, edge cases, decision trees — the command files got really long.

> One day I noticed the AI started missing steps. It skipped a section in a flowchart. It gave me test cases where the title said one thing but the objective said something else. The test steps were partly correct, partly wrong.

> And it wasn't just one command. This happened with Jira tracing, test planning, test case design. Anywhere I had a long file, the AI would lose track of what to do halfway through.

> So I made a big change. Let me show you what I started with.

---

## Section 3: THE OLD WAY — v1.0 (2-3 min)

> In v1.0, I had three main command files.

**[SHOW: Open `demo/v1_commands/jira-trace.md`. Scroll through it.]**

> First, the Jira trace command. 209 lines. It fetched tickets, followed links, pulled in Confluence documents, and organized everything — all in one file. Not the worst, but still a lot of context for the AI to hold.

**[SHOW: Open `demo/v1_commands/test-planning-checklist.md`. Scroll slowly through it.]**

> Next, the test planning command. 1,271 lines. This is the big one. One file tried to handle everything — detect if you're testing a new feature, a bug fix, or an enhancement. Gather info from Jira and Confluence. Then create the full test plan. Whole different workflows mixed together. The AI had to read the whole thing and figure out which part to follow.

**[SHOW: Open `demo/v1_commands/test-case-design-checklist.md`.]**

> This one is test case design. 814 lines for creating test cases. Features, bug fixes, enhancements — all in one file. Plus HTML formatting rules for TestLink, quality checklists, templates.

> These three files — over 2,200 lines total. Too much context for one command. The AI would start strong at the top, but by the time it got halfway through, it started mixing things up. Steps would reference the wrong section. That's the problem with single monolithic instructions.

---

## Section 4: THE NEW WAY — v2.0 (5-6 min)

### 4A: The Pattern (30 sec)

> So I broke them apart. A short entry-point command reads your project, figures out what kind of work it is, and routes you to the right specialist command. Each specialist does exactly one job. And every command ends with a clear next step — here's what to run next.

### 4B: Jira Trace Pipeline (1 min)

**[SHOW: Open `commands/jira/` directory listing.]**

> The Jira trace pipeline. The old Jira trace markdown file did everything. Now I have a little entry point. It calls four sub-commands in sequence: fetch, structure, download, verify.

> `jr-trace-fetch` pulls the ticket and all linked issues. `jr-trace-structure` organizes what it found into project files. `jr-trace-docs` downloads the raw documentation faithfully. `jr-trace-verify` validates downloads against source and generates summary files. Each one does its job and passes the result to the next. That's a sequential pipeline.

> Compared to the old file — same result, but now each piece is small enough that the AI doesn't lose track.

### 4C: Test Workflow Router (3 min)

**[SHOW: Open `commands/test-workflow/` directory listing — 13 files.]**

> This is where the two big single files became 13 focused commands.

**[SHOW: Open `commands/test-workflow/tw-plan-init.md`.]**

> `tw-plan-init`. This is the starting point for test planning. It reads your project files. Detects what type of testing you need — new feature, bug fix, or enhancement — and tells you which command to run next. That's all it does. One job.

**[SHOW: Open `commands/test-workflow/tw-plan-feature.md`.]**

> `tw-plan-feature`. Feature test planning only. Nothing about bug fixes. Nothing about enhancements. Just features.

**[SHOW: Open `commands/test-workflow/tw-plan-review.md`.]**

> `tw-plan-review`. It reads your test plan, builds a coverage matrix, checks for gaps. Version 1.0 didn't have a review step. You just went straight from planning to writing test cases. We used to review the test plan manually and check the coverage by yourself. Now we have a command for that.

**[SHOW: Open `commands/test-workflow/tw-case-init.md`.]**

> After the test plan is reviewed, we go to `tw-case-init`. It reads the test plan, detects the type, and routes you to the right command.

**[SHOW: Open `commands/test-workflow/tw-case-feature.md`.]**

> `tw-case-feature` writes the actual test cases.

**[SHOW: Open `commands/test-workflow/tw-case-review.md`.]**

> `tw-case-review`. Checks every test case — are the objectives clear? Are the steps specific? Are the expected results measurable? We didn't have a test case review command before. We did it manually. Now we have a command to help us.

### 4D: TestLink Sync and Demo Pipeline (1 min)

**[SHOW: Open `commands/testlink/tl-sync.md`.]**

> Now we go to TestLink sync. We don't just push everything to the test case management system. It compares your local test cases against what's already there. If a case exists and hasn't changed, it skips it. If it's new, it creates it. If it changed, it updates it. Think of it like `git diff` but for test management.

**[SHOW: Open `commands/project/` directory listing.]**

> `/pm-demo-content` generates demo presentation content. `/pm-demo-review` reviews the demo. After the review, `/pm-demo-ppt` generates a PowerPoint file from the result. And `/pm-demo-email` handles announcements. These four commands work together instead of one giant file.

### 4E: Summary (15 sec)

> So we have three different command groups that handle the AI QA flow.

---

## Section 5: HOW TO USE IT — Installation (2 min)

> Now let me show you how to use it.

**[SHOW: Terminal.]**

> If you don't have these commands yet, you can git pull from the repository and run `make install`. It will install to your user folder.

**[SHOW: Run `make install` in terminal.]**

> If you already have the commands, be careful. If you think the current commands still work for you, you don't have to update. I recommend everybody to have your own commands and make your own modifications.

**[SHOW: Output of `make install` showing installation to `~/.claude/commands/` and `~/.claude/skills/`.]**

> The commands and skills are installed to the user folder under `~/.claude/`.

---

## Section 6: DEMO — Running Slash Commands (1 min)

**[SHOW: Open Claude Code. Type `/`.]**

> Let's try Claude Code. You can see the Jira trace here.

> If you enter `/jr-trace`, it will ask for a project or Confluence page number to trace the whole project. You need the MCP tools set up for this to work.

---

## Section 7: MCP SERVER SETUP (3-4 min)

**[SHOW: Open MCP integration docs / cheat sheet.]**

> Let me show you the MCP setup. These are the MCP tools from GitHub. If you're using Claude Code, you need to run a setup command to connect your code agent to Jira or other services. The code agent initializes an MCP client, the client uses the MCP protocol to talk to the MCP server, and the server runs the API calls for you.

> There's also a UVX option. I've prepared a cheat sheet for everybody.

### MCP Servers Available

**[SHOW: MCP server documentation / cheat sheet.]**

> We also prepared some useful MCP servers for you.

> **Playwright MCP** — This is a browser MCP server. It can control your browser. It can also run in Docker using headless mode. After you set it up, your AI agent can control a browser on its own. Very useful for GUI testing — verifying test steps or running test cases.

> **RADIUS SQL MCP** — As you know, FreeRADIUS can read users from a SQL server. I run an MCP server on it. So Claude Code can use MCP to check authentication or accounting from the AI code agent.

> **TestLink MCP** — TestLink is a very old test case management system. Not many people use it now. But this is an example — if your company doesn't use TestLink, you need to find your own way. Even if your test case management system doesn't provide an MCP server, you can write your own. It's not that hard to write an MCP server — it calls the API or CLI. It's even easier today. This one is written by me. TestLink didn't have an MCP server, so this is also my repository.

> **WPA MCP** — As you know, WPA supplicant can be controlled by WPA CLI or configuration files. I wrote an MCP server for it so you can control the wireless client from the IDE.

> The main goal of AI QA Workflow is using the IDE and AI code agents to operate many things — release the QA mind, everybody's mind, to focus on more important things.

**[SHOW: MCP server configuration cheat sheet.]**

> This is the MCP server configuration cheat sheet for you.

---

## Section 8: CLOSING (30 sec)

> Thank you for watching. This is the major update — version 2.0 of AI QA Workflow. This is how I think modern quality assurance should do things.

> Thank you. Thank you for watching.

---

## Production Notes

**Screen share order:**
1. GitHub repo overview
2. `demo/v1_commands/jira-trace.md` (scroll through)
3. `demo/v1_commands/test-planning-checklist.md` (scroll through)
4. `demo/v1_commands/test-case-design-checklist.md` (scroll through)
5. `commands/jira/` directory listing
6. `commands/test-workflow/` directory listing
7. v2.0 files: `tw-plan-init.md`, `tw-plan-feature.md`, `tw-plan-review.md`, `tw-case-init.md`, `tw-case-feature.md`, `tw-case-review.md`
8. `commands/testlink/tl-sync.md`
9. `commands/project/` directory listing
10. Terminal: `make install`
11. Claude Code: slash command demo
12. MCP integration docs / cheat sheet
13. MCP server repos: Playwright, RADIUS SQL, TestLink, WPA

**v1.0 files located at:**
```
demo/v1_commands/jira-trace.md                (209 lines)
demo/v1_commands/test-planning-checklist.md   (1,271 lines)
demo/v1_commands/test-case-design-checklist.md (814 lines)
```
