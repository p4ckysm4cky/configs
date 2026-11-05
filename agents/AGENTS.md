# Agent instructions

## Communication

- When the user mentions "planning," display the plan in chat and do not create a file.
- Do not use em dashes in responses or documentation.

## Tools

- Prefer `fd` for finding files and `rg` (ripgrep) for searching file contents. Use alternatives when these tools are unavailable.

## Coding style

- Prefer self-documenting code with clear names and structure. Do not add code comments unless explicitly requested.

Prefer named booleans for nontrivial conditions, for example:

```csharp
bool userIsAway = user.LastActiveAt < awayThreshold;
bool userIsFreeTier = user.Role == "free";

if (userIsAway && userIsFreeTier)
{
    SendReminder(user);
}
```
