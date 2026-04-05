---
name: claude.create-skill
description: Scaffold a new Claude Code skill (SKILL.md) at either project level (.claude/skills/ in git root) or global level (~/.claude/skills/). Asks user for placement, name, and purpose, then generates the skill file.
---

# Create Skill

Scaffold a new Claude Code skill by creating the directory and `SKILL.md` file.

## Usage

```
/create-skill [skill-name]
```

If `[skill-name]` is not provided, ask the user for a name.

## Workflow

1. **Get the skill name**
   - If not supplied as an argument, ask: "What should the skill be called? (lowercase, hyphen-separated, e.g. `deploy-staging`)"
   - Validate: lowercase alphanumeric and hyphens only; no spaces or underscores.

2. **Ask for placement level**
   - Ask the user: "Where should this skill live?"
     - **Project level** — `<git-repo-root>/.claude/skills/<skill-name>/SKILL.md` (checked into the repo, available only in this project)
     - **Global level** — `~/.claude/skills/<skill-name>/SKILL.md` (available across all projects on this machine)
   - Do not proceed until the user confirms.

3. **Gather skill details**
   Ask the user for the following (can be answered in one message):
   - **Description:** One-line summary of what the skill does (used in the skill list and frontmatter).
   - **Purpose / workflow:** What should the skill do when invoked? Collect enough detail to write a useful Workflow section. Ask clarifying questions if the purpose is vague.
   - **Arguments:** Does the skill accept any arguments? If yes, what are they and which are optional?
   - **Prerequisites:** Any tools, files, or conditions that must exist before the skill runs?

4. **Generate the SKILL.md**
   Use this structure (matching the project's existing skill format):

   ```markdown
   ---
   name: <skill-name>
   description: <one-line description>
   ---

   # <Skill Title>

   <One-paragraph description of what the skill does.>

   ## Usage

   ```
   /<skill-name> [args]
   ```

   <Explanation of arguments, defaults, and examples.>

   ## Prerequisites

   <List any prerequisites, or remove this section if none.>

   ## Workflow

   <Numbered steps describing what the skill does when invoked.
    Each step should be clear enough for Claude to follow autonomously.
    Include decision points, user confirmations, and error handling.>
   ```

5. **Create the file**
   - Create the directory: `<target-root>/.claude/skills/<skill-name>/`
   - Write `SKILL.md` inside it.
   - Report the full path to the user.

6. **Register in CLAUDE.md (project level only)**
   - If the skill was created at **project level**, check the project's `CLAUDE.md` for a skills section.
   - If a skills section exists, append a one-line entry for the new skill (matching the existing format).
   - If no skills section exists, ask the user if they want one added.
   - **Global skills** do not need CLAUDE.md registration.

7. **Confirm**
   - Show the user the generated SKILL.md content for review.
   - Ask if they want any changes before finalizing.

## Notes

- Skill names must be unique within their level (project or global). If a skill with the same name already exists at the chosen level, warn the user and ask whether to overwrite or pick a different name.
- The generated SKILL.md should be detailed enough that Claude can follow the workflow autonomously when the skill is invoked.
- Keep the tone and structure consistent with existing skills in the project.
