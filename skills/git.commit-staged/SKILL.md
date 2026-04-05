---
name: git.commit-staged
description: Commit staged changes with an appropriate commit message following the repository's existing style.
---

# Commit Staged

Commit staged changes with an appropriate commit message.

## Usage

```
/commit-staged
```

## Workflow

1. Run `git status` to see all modified, deleted, and untracked files
2. **Ask the user which files to stage**:
   - List all unstaged modified/deleted files and untracked files, each with a number
   - Ask the user to provide the numbers of files they want to add, or ask if they want to add all
   - Stage the selected files using `git add`
3. Run `git diff --staged` to review the staged changes
4. Run `git log --oneline -5` to see recent commit message style
5. Analyze the changes and create a concise, one-line commit message that describes what was changed
6. Commit the changes using `git commit -m "your message"`
7. DO NOT add any Claude-generated markers, attribution, or co-authored-by tags
8. Keep the commit message simple and follow the repository's existing commit message style
