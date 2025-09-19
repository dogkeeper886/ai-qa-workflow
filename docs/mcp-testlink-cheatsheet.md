# MCP TestLink Configuration

## Repository
https://github.com/dogkeeper886/testlink-mcp

## Configuration

### MCP Server Configuration
```json
{
  "mcpServers": {
    "testlink": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-e", "TESTLINK_URL",
        "-e", "TESTLINK_API_KEY",
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

## Available Tools

### Read Operations
- `read_test_case`: Fetch complete test case data
- `list_projects`: Get all test projects
- `list_test_suites`: Get test suites for a project
- `list_test_cases_in_suite`: Get all test cases in a suite
- `search_test_cases`: Search for test cases by name in a project

### Update Operations
- `update_test_case`: Update test case fields with validation
- `bulk_update_test_cases`: Update multiple test cases at once

### Create Operations
- `create_test_case`: Create new test case with validation
- `create_test_suite`: Create a new test suite in a project

### Delete Operations
- `delete_test_case`: Remove test case permanently
- `archive_test_case`: Archive a test case (marks as obsolete)
