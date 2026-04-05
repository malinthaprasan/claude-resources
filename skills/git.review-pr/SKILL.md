---
name: git.review-pr
description: Review a pull request interactively by setting up a worktree and enabling conversation-based review.
---

# Review PR

Review a pull request interactively. Sets up a worktree and enables conversation-based review.

## Usage

```
/review-pr <pr-number-or-url>
```

**Input:** PR number or URL (e.g., `845` or `https://github.com/wso2/api-platform/pull/845`)

## Workflow

### Step 1: Parse PR Input

Extract the PR number from the input (handle both `845` and full URL formats like `https://github.com/wso2/api-platform/pull/845`).

### Step 2: Fetch PR Metadata

```bash
gh pr view <PR_NUMBER> --repo wso2/api-platform --json number,title,body,author,state,baseRefName,headRefName,headRepository,headRepositoryOwner
```

Extract:
- PR number
- Title (sanitize for directory name - replace spaces with dashes, remove special chars)
- Head branch and repository info for fetching

### Step 3: Setup Git Worktree

Create a worktree at `../ap-pr-reviews/<sanitized-title>-<pr-number>/`:

```bash
# Create the reviews directory if it doesn't exist
mkdir -p ../ap-pr-reviews

# Add the PR author's fork as a remote if not already added
git remote add pr-<PR_NUMBER> https://github.com/<headRepositoryOwner>/api-platform.git 2>/dev/null || true
git fetch pr-<PR_NUMBER> <headRefName>

# Create worktree from the PR branch
git worktree add ../ap-pr-reviews/<sanitized-title>-<pr-number> pr-<PR_NUMBER>/<headRefName>
```

### Step 4: Gather Initial Context

Fetch and display:
```bash
gh pr diff <PR_NUMBER> --repo wso2/api-platform --stat
gh pr checks <PR_NUMBER> --repo wso2/api-platform
gh pr view <PR_NUMBER> --repo wso2/api-platform
```

List the changed files and their types (Go, YAML, etc.).

### Step 5: Present Review Dashboard

Display to user:

```
## PR Review Session: #<NUMBER> - <TITLE>

**Worktree:** ../ap-pr-reviews/<dirname>
**Author:** <author>
**Branch:** <head> -> <base>
**Files Changed:** <count>

### Changed Files:
<list of files with +/- stats>

### CI Status:
<pass/fail status>

---

Ready for interactive review. You can ask me to:
- Analyze specific files or changes
- Check for security issues
- Review test coverage
- Compare with existing patterns in main
- Explain what a change does
- Look for potential bugs

What would you like to review first?
```

### Conversation Mode

In this mode, respond to user questions by:
- Reading files from both the worktree (PR code) and main repo (for comparison)
- Using `gh pr diff` to show specific file changes
- Analyzing code for issues, patterns, security concerns
- Comparing implementations between PR and main branch

## Cleanup Note

When done, user can remove the worktree with:
```bash
git worktree remove ../ap-pr-reviews/<dirname>
git remote remove pr-<PR_NUMBER>
```
