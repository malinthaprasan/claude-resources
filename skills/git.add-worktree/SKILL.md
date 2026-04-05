---
name: git.add-worktree
description: Create a new git worktree for working on a branch in a separate directory.
---

# Add Git Worktree

Create a new git worktree for working on a branch in a separate directory.

## Usage

```
/add-worktree
```

## Workflow

1. **Ask the user for the worktree type**:
   - "New branch" - Create a new branch based on an existing branch
   - "Existing branch" - Checkout an existing branch in a new worktree

2. **Ask for the branch name** (this will also be used as the folder name)

3. If creating a new branch, ask for the **base branch** (e.g., `main`, `develop`)

4. **Execute the appropriate git command**:

   For a new branch:
   ```bash
   git worktree add -b <branch_name> /home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name> <base_branch>
   ```

   For an existing branch:
   ```bash
   git worktree add /home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name> <branch_name>
   ```

5. **After creation**:
   - Confirm the worktree was created successfully
   - Show the path to the new worktree: `/home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name>`
   - Optionally list all worktrees with `git worktree list`
