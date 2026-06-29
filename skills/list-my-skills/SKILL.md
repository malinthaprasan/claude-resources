---
name: list-my-skills
description: List all skills added by the user — both global (~/.claude/skills/) and project-level (.claude/skills/), showing each skill's name, a short description of what it does, and whether it is global or project scoped.
---

# List My Skills

List every skill the user has added, covering both **global** skills (under `~/.claude/skills/`) and **project** skills (under `.claude/skills/` in the current repo / working directory).

## Instructions

1. Collect global skills from `~/.claude/skills/` and project skills from `./.claude/skills/`. For each `SKILL.md`, read the `name` and `description` from the frontmatter:

   ```bash
   list_skills() {
     local scope="$1" base="$2"
     for f in "$base"/*/SKILL.md; do
       [ -e "$f" ] || continue
       name=$(grep -m1 '^name:' "$f" | sed 's/^name:[[:space:]]*//')
       desc=$(grep -m1 '^description:' "$f" | sed 's/^description:[[:space:]]*//')
       echo "[$scope] ${name:-$(basename "$(dirname "$f")")} :: ${desc:-(no description)}"
     done
   }
   list_skills global "$HOME/.claude/skills"
   list_skills project "./.claude/skills"
   ```

2. Present the result to the user grouped by scope, e.g.:

   ```
   ## Global skills (~/.claude/skills/)
   - <name> — <short description of what it does>

   ## Project skills (.claude/skills/)
   - <name> — <short description of what it does>
   ```

   Keep each description short (one line). Clearly indicate the scope (global vs project) for each skill.

3. Report the total count for each scope.

Notes:
- Only list skills the user added: global (`~/.claude/skills/`) and project (`.claude/skills/`). Do not include plugin or bundled/built-in skills.
- If a scope's directory is empty or missing, say so for that scope instead of erroring.
