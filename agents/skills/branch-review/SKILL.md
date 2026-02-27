---
name: branch-review
description: Perform a focused code review of the current branch against a target branch. Use this when asked to review a branch, pull request, or set of commits.
---

# Branch Review Skill

Use this skill to review changes in the current branch compared with a target branch, then produce concise, actionable feedback. Make sure to use the codebase as reference.

## When to use

- The user asks to compare one branch against another.
- The user asks for PR-style findings (bugs, risks, maintainability issues).

## Inputs to collect

- `target_branch`: The base branch to compare against. Prefer the `origin/<branch>` form (e.g., `origin/main`, `origin/develop`) to compare against the up-to-date remote-tracking ref. Fall back to the local branch name (e.g., `main`) only if no remote is configured.
- `scope` (optional): Specific folders/files to prioritize.

If `target_branch` is not provided, default to `origin/main` or `origin/master`. If no remote-tracking ref exists, fall back to local `main` or `master`.

## Review workflow

1. Refresh branch references.
    - Run: `git fetch`
    - Do not prune

2. Confirm current branch and target branch.
    - Get current branch: `git rev-parse --abbrev-ref HEAD`
    - Ensure target branch exists: `git -P branch -a`
    - Verify the resolved `target_branch` appears in the output.
    - **If the target branch is not found: stop and report** — do not proceed with the review. Ask the user to confirm the correct target branch name.

3. Compute review diff.
    - File summary: `git -P diff --stat <target_branch>...HEAD`
    - Full patch: `git -P diff <target_branch>...HEAD`
    - Commit list: `git -P log --oneline <target_branch>..HEAD`

4. Prioritise high-risk areas first.
    - Security-sensitive logic
    - Auth and permissions
    - Data access, migrations, and schema changes
    - Error handling and retries
    - Concurrency/stateful logic

5. Review each changed file for:
    - Correctness and potential bugs
    - Security issues
    - Performance regressions
    - Breaking changes / API contract drift
    - Test coverage gaps
    - Readability and maintainability

6. Produce findings.
    - Sort by severity: `Critical`, `High`, `Medium`, `Low`.
    - Include concrete evidence (file path + rationale).

## Output format

Use this exact structure:

1. **Review Scope**
    - Current branch
    - Target branch
    - Files reviewed
    - Commits reviewed

2. **Findings**
    - Severity: `Critical | High | Medium | Low`
    - File(s):
    - Issue:
    - Why it matters:
    - Suggested fix:

## Review guardrails

- **Stop immediately if the target branch cannot be found.** Report the missing branch and ask the user to provide a valid target before proceeding.
- Do not invent issues without evidence in the diff.
- Prefer fewer, high-signal findings over many low-value comments.
- If unsure, mark as "needs confirmation" and explain why.
- Keep suggestions aligned with existing repository conventions.

## Example command sequence

```bash
# 1. Refresh branch references
git fetch

# 2. Confirm current branch and target branch
git rev-parse --abbrev-ref HEAD
git -P branch -a

# 3. Compute review diff
git -P diff --stat origin/main...HEAD
git -P log --oneline origin/main..HEAD
git -P diff origin/main...HEAD
```
