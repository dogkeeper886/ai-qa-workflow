# Jira Ticket Trace and Folder Organization

```
Trace Jira tickets and organize them into a clear folder structure, including comments:

Jira Issue Key: {{input}}

## Steps:
1. Get the main ticket details with ALL comments using expand parameter
2. Find related tickets (parent, children, linked issues)
3. **Retrieve and analyze comments from EVERY ticket** - comments contain:
   - Important discussions about customer problems
   - Reproduction steps and technical details
   - Problem-solving conversations
   - Customer-reported behaviors and workarounds
4. Create organized folder structure with clear naming
5. Use numbered prefixes (00_, 01_, 02_) for hierarchy levels
6. Create README files for each subfolder
7. Focus on understanding the problem through ticket content AND comments

## Folder Structure:
- 00_Main_Task_[TICKET].md (main task file with full ticket content + comments)
- [TICKET]_[DESCRIPTION]/ (subfolders for related tickets)
  - 01_[DESCRIPTION]_[TICKET].md (first level files with comments)
  - [SUBTICKET]_[DESCRIPTION]/ (nested subfolders)
    - 02_[DESCRIPTION]_[SUBTICKET].md (second level files with comments)
- README.md (overview with problem summary + key discussion points from comments)
- Ticket_Relationship_Diagram.md (complete trace)

## Important: Comment Retrieval
**ALWAYS use the MCP Atlassian jira_get_issue tool with comment_limit parameter set high (e.g., 100) or use expand='comments' to ensure ALL comments are retrieved. Comments often contain critical information not in the ticket description.**

## Naming Rules:
- Use numbers to show folder depth (00_, 01_, 02_)
- Keep names short and clear
- Include ticket number in filename
- Use underscores instead of spaces
```

