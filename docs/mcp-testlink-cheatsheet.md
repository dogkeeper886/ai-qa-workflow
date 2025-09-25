# MCP TestLink Configuration

## Repository
https://github.com/dogkeeper886/testlink-mcp

## Configuration

### Docker Command (Claude Code)
```bash
claude mcp add testlink -- docker run --rm -i \
  -e TESTLINK_URL=http://192.168.x.x/testlink \
  -e TESTLINK_API_KEY=your_api_key_here \
  dogkeeper886/testlink-mcp:latest
```

### Docker Command (Direct)
```bash
docker run --rm -i \
  -e TESTLINK_URL=http://your-testlink-server.com/testlink \
  -e TESTLINK_API_KEY=your_api_key_here \
  dogkeeper886/testlink-mcp:latest
```

### Environment Variables
- `TESTLINK_URL`: http://your-testlink-server.com/testlink
- `TESTLINK_API_KEY`: your_api_key_here

### MCP Server Configuration (Cursor IDE)
```json
{
  "mcpServers": {
    "testlink": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-e",
        "TESTLINK_URL=http://your-testlink-server.com/testlink",
        "-e",
        "TESTLINK_API_KEY=your_api_key_here",
        "dogkeeper886/testlink-mcp:latest"
      ],
      "env": {
        "TESTLINK_URL": "http://your-testlink-server.com/testlink",
        "TESTLINK_API_KEY": "your_testlink_api_key"
      }
    }
  }
}
```
