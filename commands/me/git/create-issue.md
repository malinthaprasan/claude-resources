# Create GitHub Issue

You are helping the user create a GitHub issue in the repository https://github.com/wso2/api-platform.

## Issue Templates

The repository has the following issue templates in `.github/ISSUE_TEMPLATE/`:

### Bug (bug.yml)
- **Description**: A clear and concise description of the problem
- **Steps to Reproduce**: List the steps to reproduce the issue (REQUIRED)
- **Environment Details**: OS, Client, versions, etc. (optional)

### Improvement (improvement.yml)
- **Current Limitation**: Describe the current limitation (REQUIRED)
- **Suggested Improvement**: Describe the improvement you suggest (REQUIRED)
- **Version**: Component version (optional)

### Feature (new-feature.yml)
- **Problem**: What problem will this feature solve? (REQUIRED)
- **Proposed Solution**: Describe the solution you'd like (REQUIRED)
- **Alternatives**: Any alternatives considered (optional)
- **Version**: Product/component version (optional)

### Task (task.yml)
- **Description**: A clear description of what needs to be done (REQUIRED)
- **Version**: Product/component version (optional)

## Your Task

1. **Ask the user for the issue type** if not already provided:
   - bug
   - improvement
   - feature
   - task

2. **Based on the issue type, gather the required information** according to the template structure above. Ask clarifying questions if the user's input is incomplete or unclear.

3. **Create the GitHub issue** using the `gh` CLI tool with the appropriate labels and body content:
   - For bug: use label `Type/Bug`
   - For improvement: use label `Type/Improvement`
   - For feature: use label `Type/New Feature`
   - For task: use label `Type/Task`

4. **Format the issue body** as markdown with clear sections matching the template fields.

5. **Execute the command** to create the issue:
   ```bash
   gh issue create --repo wso2/api-platform --title "<title>" --body "<body>" --label "<label>"
   ```

6. **Confirm with the user** before creating the issue and show them the final issue content.

## Important Notes

- Always validate that all REQUIRED fields are provided before creating the issue
- Ask clarifying questions if any information is ambiguous or incomplete
- Format the issue body clearly with proper markdown headers
- Use the exact label names as specified above