---
name: add-myscript
description: Add a new bash script to the personal scripts folder (/home/malintha/scripts/) following existing conventions.
---

# Add Script to Personal Scripts Folder

Create a new bash script in `/home/malintha/scripts/` following the existing conventions.

## Instructions

1. Ask the user for:
   - Script name (if not provided as argument: $ARGUMENTS)
   - What the script should do

2. Follow the existing script patterns:
   - Use `#!/bin/bash` shebang
   - Keep scripts simple and focused
   - Include usage message if the script requires arguments
   - Use `$*` or `$@` to pass through arguments where applicable

3. Create the script file at `/home/malintha/scripts/<script-name>`

4. Make the script executable with `chmod +x`

5. Confirm creation and show how to use the script

ARGUMENTS: $ARGUMENTS
