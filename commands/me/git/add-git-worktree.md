# Add Git Worktree

Create a new git worktree for working on a branch in a separate directory.

## Instructions

Ask the user for the following information using AskUserQuestion:

1. **Worktree type**:
   - "New branch" - Create a new branch based on an existing branch
   - "Existing branch" - Checkout an existing branch in a new worktree

2. **Branch name**: The name of the branch (this will also be used as the folder name)

3. If creating a new branch, ask for the **base branch** (e.g., `main`, `develop`)

## Execution

Once you have the information, execute the appropriate git command:

### For a new branch:
```bash
git worktree add -b <branch_name> /home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name> <base_branch>
```

### For an existing branch:
```bash
git worktree add /home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name> <branch_name>
```

## After creation

1. Confirm the worktree was created successfully
2. Show the path to the new worktree: `/home/malintha/wso2apim/gitworkspace/ap-worktrees/<branch_name>`
3. Optionally list all worktrees with `git worktree list`
