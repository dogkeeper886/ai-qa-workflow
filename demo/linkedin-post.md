I just open-sourced AI QA Workflow -- a toolkit that lets AI coding agents run your entire QA lifecycle through slash commands and MCP integrations.

The problem: I was writing markdown instructions for AI agents to do QA tasks. It worked great until the files got too long. At 1,200+ lines, the AI started losing context -- skipping steps, mixing up workflows, giving inconsistent results.

The solution came in two layers:

**53 Slash Commands with Orchestration**

Instead of monolithic instructions, I built an orchestra of small, focused commands. A short entry-point command reads your project, detects what kind of work it is (new feature? bug fix? enhancement?), and routes to the right specialist. Each specialist does exactly one job. Every command ends with a "next step" hint so the agent always knows what to run next.

Three orchestration patterns emerged:
- Sequential pipeline (fetch -> structure -> document)
- Fan-out router (detect type -> route to specialist)
- Smart diff (compare local vs remote, apply only changes)

**8 Agent Skills for Guided Workflows**

Skills are the high-level layer. Each skill covers a complete lifecycle phase with a built-in progress checklist and validation steps:

Receiving tickets -> Planning tests -> Designing cases -> Syncing to TestLink -> Executing tests

Plus skills for drafting review emails, creating demo presentations, and analyzing test logs.

The key insight: markdown files are both the documentation AND the executable instructions. No code generation, no compilation. Define once, deploy to both Claude Code and Cursor.

All powered by MCP (Model Context Protocol) integrations with Jira, Confluence, TestLink, and Playwright for browser automation.

Open source: github.com/dogkeeper886/ai-qa-workflow

#QA #TestAutomation #AI #MCP #OpenSource #ClaudeCode #SoftwareTesting
