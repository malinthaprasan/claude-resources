---
name: dev.create-spec
description: Create a specification.md for a feature request based on user-provided requirements.
---

# Create Specification

Produces a `specification.md` file in the current working directory for a feature request.
Focuses strictly on requirements and format — no implementation details unless explicitly asked.
Asks clarifying questions rather than making assumptions.

## Usage

```
/dev.create-spec [brief description of the feature]
```

If no description is provided, ask the user to describe the feature they want to specify.

## Workflow

1. **Gather requirements**
   - Ask the user to describe the feature if not already provided.
   - Read any referenced files or architecture docs the user points to.
   - Ask clarifying questions for anything ambiguous before writing. Do not assume.
   - Confirm your understanding with the user before proceeding.

2. **Draft the specification**
   - Focus on *what* the feature does, not *how* to implement it.
   - Do not include implementation details (code snippets, controller names, function signatures, etc.) unless the user explicitly asks for them.
   - Structure the spec with clear sections (e.g. Purpose, Endpoints/Behaviour, Format, Rules, Open Questions).
   - List any unresolved decisions or assumptions as **Open Questions** at the end.

3. **Review loop**
   - Present the draft to the user.
   - Incorporate feedback, ask follow-up questions where needed.
   - Repeat until the user approves.

4. **Write output**
   - Write the final content to `specification.md` in the current working directory.
   - Confirm the file path to the user.

## Notes

- Never add implementation details (routes, controller names, SQL, etc.) unless the user asks.
- Always ask rather than assume when requirements are unclear.
- Keep open questions explicit — do not silently resolve ambiguities.
