---
name: branch-summary
description: Summarise changes between two branches with a per-file breakdown. Use this when asked to summarise, describe, or explain what changed in a branch.
---

# Branch Summary Skill

Use this skill to produce a clear, per-file summary of every change in the current branch compared with a target branch. The goal is comprehension, not critique — describe _what_ changed and _why_ it likely changed.

## When to use

- The user asks to summarise or describe the changes in a branch.
- The user wants a changelog-style breakdown of what was modified.
- The user needs context on what a branch introduces before a review or merge.

## Inputs to collect

- `target_branch`: The base branch to compare against. Prefer the `origin/<branch>` form (e.g., `origin/main`, `origin/develop`) to compare against the up-to-date remote-tracking ref. Fall back to the local branch name (e.g., `main`) only if no remote is configured.
- `scope` (optional): Specific folders/files to limit the summary to.

If `target_branch` is not provided, default to `origin/main` or `origin/master`. If no remote-tracking ref exists, fall back to local `main` or `master`.

## Summary workflow

1. Refresh branch references.
    - Run: `git fetch`
    - Do not prune.

2. Confirm current branch and target branch.
    - Get current branch: `git rev-parse --abbrev-ref HEAD`
    - Ensure target branch exists: `git -P branch -a`
    - Verify the resolved `target_branch` appears in the output.
    - **If the target branch is not found: stop and report** — do not proceed. Ask the user to confirm the correct target branch name.

3. Gather change data.
    - File summary: `git -P diff --stat <target_branch>...HEAD`
    - Commit list: `git -P log --oneline <target_branch>..HEAD`
    - For each changed file, get its diff: `git -P diff <target_branch>...HEAD -- <file>`

4. Summarise each file.
    - Read the diff for every changed file.
    - Write a concise summary of what changed and the likely intent behind the change.
    - Note whether the file was added, modified, deleted, or renamed.
    - Group related files together when they form a logical unit of change (e.g., a component and its tests).

5. Write an overall summary.
    - A short paragraph describing the purpose of the branch as a whole, inferred from the totality of changes and commit messages.

## Output format

Use this exact structure:

### 1. Overview

| Item                | Value      |
| ------------------- | ---------- |
| Current branch      | `<branch>` |
| Target branch       | `<target>` |
| Total files changed | N          |
| Total commits       | N          |

**Branch purpose:** One-to-two sentence description of what this branch accomplishes overall.

### 2. Commits

List each commit (from `git log --oneline`) as a bullet.

### 3. Per-file summary

For each changed file (or logical group of files):

- **File:** `path/to/file`
- **Status:** Added | Modified | Deleted | Renamed
- **Summary:** A concise description of what changed and why.

Repeat for every file. Group related files under a shared heading when appropriate.

### 4. Notable patterns (optional)

Call out any cross-cutting observations, such as:

- A dependency upgrade that touches many files.
- A rename/move refactor.
- A config change that affects multiple environments.

Only include this section if there are meaningful patterns worth highlighting.

## Guardrails

- **Stop immediately if the target branch cannot be found.** Report the missing branch and ask the user to provide a valid target before proceeding.
- Describe changes factually — do not critique or suggest improvements (that is the job of branch-review).
- If a file's purpose is unclear from the diff alone, say so rather than guessing.
- Respect the optional `scope` filter — if provided, only summarise matching files.

## Example command sequence

```bash
# 1. Refresh branch references
git fetch

# 2. Confirm current branch and target branch
git rev-parse --abbrev-ref HEAD
git -P branch -a

# 3. Gather change data
git -P diff --stat origin/main...HEAD
git -P log --oneline origin/main..HEAD

# 4. Per-file diffs
git -P diff origin/main...HEAD -- path/to/file.ts
```
