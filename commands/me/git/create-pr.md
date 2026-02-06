Create a pull request to the upstream repository following these steps:

## Step 1: Analyze Changes

First, gather information about what has changed:

- Run `git remote -v` to verify the upstream remote is configured
- Run `git fetch upstream` to fetch the latest upstream branches
- Run `git diff upstream/main --stat` to see which files have changed
- Run `git log --oneline upstream/main..HEAD` to list commits ahead of upstream
- Examine documentation files in those commits (e.g., files in `<component>/spec/impls/` directories) to understand what features were implemented

## Step 2: Draft the Pull Request

Using the information gathered above, fill out this WSO2 PR template:

```
## Purpose
> Explain **why** this feature or fix is required. Describe the underlying problems, issues, or needs driving this feature/fix and include links to related issues in the following format: Resolves issue1, issue2, etc.

## Goals
> Describe **what solutions** this feature or fix introduces to address the problems outlined above.

## Approach
> Describe **how** you are implementing the solutions. Include an animated GIF or screenshot if the change affects the UI. Include a link to a Markdown file or Google doc if the feature write-up is too long to paste here.

## User stories
> Summary of user stories addressed by this change>

## Documentation
> Link(s) to product documentation that addresses the changes of this PR. If no doc impact, enter “N/A” plus brief explanation of why there’s no doc impact

## Automation tests
 - Unit tests 
   > Code coverage information
 - Integration tests
   > Details about the test cases and coverage

## Security checks
 - Followed secure coding standards in http://wso2.com/technical-reports/wso2-secure-engineering-guidelines? yes/no
 - Ran FindSecurityBugs plugin and verified report? yes/no
 - Confirmed that this PR doesn't commit any keys, passwords, tokens, usernames, or other secrets? yes/no

## Samples
> Provide high-level details about the samples related to this feature

## Related PRs
> List any other related PRs

## Test environment
> List all JDK versions, operating systems, databases, and browser/versions on which this feature/fix was tested
```

When filling out the template:
- Use information from implementation documentation found in commit diffs
- Reference commit messages and git changes for the Approach section
- Include PRD files if they exist in the changes
- Reference architecture and design docs when relevant
- Only fill in applicable sections - mark others as "N/A" with a brief explanation

## Step 3: Review with User

Present the complete drafted PR to the user for review and approval.

## Step 4: Create the Pull Request

Once the user confirms, create the PR using:
```bash
gh pr create --repo wso2/api-platform --base main --head malinthaprasan:main --title "YOUR_TITLE" --body "FULL_PR_BODY"
```

## Important Notes

- Always verify the upstream remote is configured before proceeding
- Show the PR draft to the user before creating it
- Do not create the PR without explicit user confirmation
