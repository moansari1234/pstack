---
name: setup-pstack
description: Configure which models pstack uses per role. Detects your available models and writes an always-applied rule that overrides the skill defaults. Use for /setup-pstack, "configure pstack models", or changing pstack's model choices.
---

# Setup pstack

Write the model map into your `AGENTS.md` (ZCode's always-applied memory file) under a `## pstack model configuration` heading. The skills read it and fall back to their inline defaults when a line is absent, so this is an override layer, not a requirement.

## Steps

### 1. Detect available models

Enumerate the model slugs available to subagents with the `ListModels` tool; paste its `id` values verbatim. If you cannot detect any, ask the user to paste the slugs they have access to. Never write a slug you have not confirmed is available.

### 2. Load current state

The default role-to-model mapping is the shape shown in step 5 below. If `AGENTS.md` already has a `## pstack model configuration` section, read it and treat its values as the current choices. Otherwise start from those defaults.

### 3. Map and confirm

Show every role with its current model, marking any whose model is not in the detected set as needing a choice. Ask whether to accept as-is or change specific roles, offering the detected models as the options. Prefer AskUserQuestion over free text. For panel roles (how critics, arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per model, so the list length sets the count.

### 4. Validate

Every slug written must be in the detected set. If a chosen slug is not available, stop and ask again. A rule pointing at a model the user cannot use breaks every delegation that reads it.

### 5. Write the rule

Edit the `## pstack model configuration` section of `AGENTS.md` with one line per role, using the same labels poteto-mode uses. Replace the whole section so re-runs stay idempotent. Shape:

```
# pstack model configuration. One line per role. Delete a line to fall back to the skill default.
feature, refactoring: composer-2.5-fast
bug-fix, perf-issue: gpt-5.5-high-fast
judgment and prose: claude-opus-4-8-thinking-xhigh
how explorer: composer-2.5-fast
how explainer: claude-opus-4-8-thinking-xhigh
how critics: claude-opus-4-8-thinking-xhigh, gpt-5.5-high-fast, composer-2.5-fast
why investigators: composer-2.5-fast
why synthesizer: claude-opus-4-8-thinking-xhigh
reflect tooling: composer-2.5-fast
reflect judgment, divergent, synthesizer: claude-opus-4-8-thinking-xhigh
arena runners: claude-opus-4-8-thinking-xhigh, gpt-5.5-high-fast, composer-2.5-fast
architect runners: claude-opus-4-8-thinking-xhigh, gpt-5.5-high-fast, composer-2.5-fast
interrogate reviewers: claude-opus-4-8-thinking-xhigh, gpt-5.5-high-fast, composer-2.5-fast
```

### 6. Confirm

Tell the user the rule was written and that it applies to new sessions. Re-running this skill updates it.
