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

4. **Determine the worktree path** — do NOT ask the user. Detect the repo root and name:
   ```bash
   git rev-parse --show-toplevel
   ```
   Then construct the path as `<repo_root>/../<reponame>-wtrees/<branch_name>` (absolute path).
   Tell the user: "Creating worktree at `<worktree_path>`"

5. **Execute the appropriate git command**:

   For a new branch:
   ```bash
   git worktree add -b <branch_name> <worktree_path> <base_branch>
   ```

   For an existing branch:
   ```bash
   git worktree add <worktree_path> <branch_name>
   ```

6. **Set up remote tracking**:

   For a new branch — push to origin and set tracking in one step:
   ```bash
   git -C <worktree_path> push -u origin <branch_name>
   ```

   For an existing branch — set tracking to the matching remote branch (no push needed):
   ```bash
   git -C <worktree_path> branch --set-upstream-to=origin/<branch_name>
   ```

7. **After creation**:
   - Confirm the worktree was created successfully
   - Show the full path to the new worktree: `<worktree_path>`
   - Confirm upstream tracking is set (e.g. `git -C <worktree_path> status` will show `Your branch is up to date with 'origin/<branch_name>'`)
   - Optionally list all worktrees with `git worktree list`
