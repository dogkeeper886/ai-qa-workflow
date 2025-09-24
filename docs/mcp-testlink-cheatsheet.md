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

## Available MCP Tools (RUCD Priority Order)

### Read Operations
- `read_test_case` - Fetch complete test case data
  - Parameters: `test_case_id` (supports "50140" or "ZD-15540" formats)
- `list_projects` - Get all test projects
- `list_test_suites` - Get test suites for a project
  - Parameters: `project_id`
- `list_test_cases_in_suite` - Get all test cases in a suite
  - Parameters: `suite_id`
- `search_test_cases` - Search test cases by exact name match
  - Parameters: `project_id`, `search_text`

### Update Operations
- `update_test_case` - Update test case fields with validation
  - Parameters: `test_case_id`, `data`
- `bulk_update_test_cases` - Update multiple test cases at once
  - Parameters: `test_case_ids` (array), `data`

### Create Operations
- `create_test_case` - Create new test case with validation
  - Parameters: `data` (requires: testprojectid, testsuiteid, name, authorlogin)
- `create_test_suite` - Create new test suite in project
  - Parameters: `project_id`, `suite_name`, `details`, `parent_id`

### Delete Operations
- `delete_test_case` - Remove test case permanently
  - Parameters: `test_case_id`
- `archive_test_case` - Archive test case (marks obsolete with [ARCHIVED] prefix)
  - Parameters: `test_case_id`

## Usage Examples

```
"Read test case 123 and improve the test steps"
"Create a new test case for login functionality"
"Update test case 456 with more detailed expected results"
"List all test cases in suite 789"
"Search for test cases containing 'login' in project 1"
"Update test cases 123, 456, 789 to set importance level to 3"
"Create a new test suite called 'Authentication Tests' in project 1"
"Archive test case 999 as it's no longer relevant"
```

## Setup Requirements

### Prerequisites
- TestLink instance with XML-RPC API access enabled
- TestLink API key (generate from TestLink user profile)
- Docker or Node.js 20+

### TestLink API Setup
1. Enable XML-RPC API in TestLink configuration
2. Generate API key from TestLink user profile:
   - Login to TestLink
   - Go to "My Settings"
   - Click "Generate API Key"
3. Ensure user has appropriate permissions

## Troubleshooting

### Connection Issues
- Verify TestLink URL is accessible from Docker container
- Check API key is valid and has permissions
- Ensure TestLink XML-RPC API is enabled
- Verify URL format includes full path (e.g., `http://server/testlink`)

### API Errors
- Check TestLink version compatibility (tested with TestLink 1.9.20+)
- Verify required fields for create/update operations
- Review TestLink server logs for detailed errors
- Ensure user has sufficient permissions
