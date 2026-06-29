---
name: git.commit
description: Stage files and commit changes with an appropriate commit message following the repository's existing style. Clusters related changes into multiple commits when appropriate.
---

# Commit

Analyze changes, cluster related ones into separate commits, propose commit
messages with their files, and commit (and optionally push) after approval.

## Usage

```
/commit
/commit and push
```

If the arguments contain "push" (or "and push"), push after all commits succeed.

## Workflow

1. Run `git status` to see all modified, deleted, and untracked files.
2. Run `git log --oneline -10` to learn the repository's commit message style (tense, prefixes, capitalization, length).
3. Inspect the actual changes so clustering is informed, not guessed. Read enough of the diff to understand what each change actually does — not just which files changed:
   - `git diff` for unstaged modifications.
   - `git diff --staged` for anything already staged.
   - For untracked files/dirs, look at the new content (read key files) to
     understand what they add.
4. **Cluster the changes by theme.** Group files that belong to the same
   logical change into the same commit. Common clustering signals:
   - Same feature, skill, or component touched together.
   - A new skill plus the docs/config that reference it.
   - Files that depend on each other for the change to make sense.
   - Refactors vs. new features vs. docs-only changes belong in separate commits.
   - Unrelated changes that happen to be in the working tree at the same time
     should never share a commit.
   Prefer a small number of meaningful commits over one catch-all commit, but
   do not over-split tightly coupled changes.
5. For each cluster, draft a concise, one-line commit message in the repository's style describing what changed.
6. **Present the proposed plan to the user and wait for approval.** Present them as a numbered list, in the order they will be applied. For each:
   - The one-line commit message (following repo style).
   - The exact list of files (and note if only part of a file belongs to that cluster).
   Then ask the user to approve, or to adjust the grouping/messages. Do not
   stage or commit anything yet. If the user requests changes, re-cluster or reword and show the updated plan again.
7. After approval, execute the commits in order. For each commit, stage only that cluster's files:
   - `git reset` to clear the index, then `git add <files for this cluster>`, then `git commit -m "message"`.
   - If a cluster needs only part of a file, use `git add -p` (or apply patches) to stage just the relevant hunks.
   - Verify the commit succeeded before moving to the next group.
8. If "push" was requested, run `git push` after all commits succeed. If the branch has no upstream, push with `git push -u origin <current-branch>`. If the
   current branch is the default branch (e.g. `main`), confirm with the user
   before pushing unless they already said "push". Report the result.
9. DO NOT add any Claude-generated markers, attribution, or co-authored-by tags.
10. Keep commit messages simple, one line, and consistent with the repository's existing style.

## Notes

- If all changes genuinely belong to one logical change, propose a single
  commit; clustering does not force multiple commits.
- If the user names specific files or counts of commits, honor that over the
  automatic clustering.
