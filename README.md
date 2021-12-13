## How to start
1. Copy shell scripts to your `.vscode` folder
2. Change the tests to un in the `push.sh` script
3. Make sure they are executable (`x` permission in Linux and MacOS)
4. Copy tasks from the `tasks.json` to your `.vscode/tasks.json`
5. Optionally set up the keybinding below
6. Enjoy!

JSON keybinding:
```json
{
    "key": "f6",
    "command": "workbench.action.tasks.runTask",
    "args": "Push code"
},
```

## Modes

Use `Set Mode: ...` tasks to change mode

### Normal
Just pushes code

### TDD
Pushes code + runs tests

### TCR
Pushes code. If push fails - reverts changes. If push is successful - runs tests. If any of tests fail - reverts changes. If tests succeed - commits change with `>>> TCR wip` message
