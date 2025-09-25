# MCP Playwright Configuration

## Repository
https://github.com/microsoft/playwright-mcp

## Configuration

### NPX Command (Claude Code)
```bash
claude mcp add playwright -- npx @playwright/mcp@latest
```

### NPX Command (Direct)
```bash
npx @playwright/mcp@latest
```

### Docker Command (Claude Code)
```bash
claude mcp add playwright -- docker run -i --rm --init --pull=always \
  mcr.microsoft.com/playwright/mcp
```

### Docker Command (Direct)
```bash
docker run -i --rm --init --pull=always mcr.microsoft.com/playwright/mcp
```

### MCP Server Configuration (Cursor IDE)
```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

### Docker Configuration (Cursor IDE)
```json
{
  "mcpServers": {
    "playwright": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "--init",
        "--pull=always",
        "mcr.microsoft.com/playwright/mcp"
      ]
    }
  }
}
```
