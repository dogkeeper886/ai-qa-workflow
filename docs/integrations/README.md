# MCP Server Configuration Cheat Sheet

Quick reference for the **optional** MCP servers you can wire up to extend what agent-workflows agents can do. The workflows need none of these — they run on the `gh` CLI.

## Configuration Formats

Each MCP server can be configured in two ways:

- **Claude Code CLI** - `claude mcp add` commands for terminal-based setup
- **JSON Configuration** - JSON blocks for MCP-compatible IDEs

## MCP Servers

The first three have full config cheat-sheets here; the rest link to their own repos for setup.

| Server | Purpose | Setup |
|--------|---------|-------|
| [mcp-playwright](mcp-playwright.md) | Browser automation | NPX, Docker |
| [mcp-wpa](mcp-wpa.md) | WiFi via `wpa_supplicant` | HTTP, Docker |
| [mcp-radius-sql](mcp-radius-sql.md) | RADIUS database queries | HTTP |
| [ai-qa-step-graph](https://github.com/dogkeeper886/ai-qa-step-graph) | Semantic test-step reuse (pgvector step-store) | see repo |
| [android-wifi-mcp](https://github.com/dogkeeper886/android-wifi-mcp) | WiFi control on Android via ADB | see repo |
| [testlink-mcp](https://github.com/dogkeeper886/testlink-mcp) | TestLink case management | see repo |
| [Atlassian Rovo MCP](https://www.atlassian.com/platform/remote-mcp-server) | Jira / Confluence | HTTP (remote) |
| [test-framework-template](test-framework-template.md) | Dual-judge test framework | N/A (not an MCP server) |

## Prerequisites

- **Docker** - Required for Docker-based configurations
- **Node.js** - Required for NPX-based configurations
- **Python/uv** - Required for uvx-based configurations
- **Claude Code CLI** - Required for `claude mcp add` commands

## Related Resources

- [Design Principles](../design/)
