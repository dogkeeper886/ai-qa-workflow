# Jira Ticket Trace and Folder Organization

```
Trace Jira tickets and organize them into a clear folder structure, including comments:

Jira Issue Key: {{input}}

## Steps:
1. Get the main ticket details
2. Find related tickets (parent, children, linked issues)
3. Create organized folder structure with clear naming
4. Use numbered prefixes (00_, 01_, 02_) for hierarchy levels
5. Create README files for each subfolder
6. Focus on understanding the problem
7. Include comments from all related tickets

## Folder Structure:
- 00_Main_Task_[TICKET].md (main task file)
- [TICKET]_[DESCRIPTION]/ (subfolders for related tickets)
  - 01_[DESCRIPTION]_[TICKET].md (first level files)
  - [SUBTICKET]_[DESCRIPTION]/ (nested subfolders)
    - 02_[DESCRIPTION]_[SUBTICKET].md (second level files)
- README.md (overview with problem summary)
- Ticket_Relationship_Diagram.md (complete trace)

## Naming Rules:
- Use numbers to show folder depth (00_, 01_, 02_)
- Keep names short and clear
- Include ticket number in filename
- Use underscores instead of spaces
```