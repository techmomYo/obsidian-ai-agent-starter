# AGENTS.md — [REPLACE: project name]
# Cross-tool AI instruction file — the single source of project instructions
# Replace every marker that starts with REPLACE: with your own content before your first commit

> Follows the AGENTS.md open standard (https://agents.md). `CLAUDE.md` and
> `GEMINI.md` only import this file. In a monorepo the nearest `AGENTS.md`
> wins. Explicit user prompts override everything here.

---

## Project overview

[REPLACE: one paragraph — what this project is, what it produces, who it is for.
Keep under 5 sentences. This is the first thing every AI tool reads.]

Six layers, each with a trust level. The folder structure is in `SPEC.md`
section 6 — read it only when adding folders, changing scope, or creating
layer content. Every folder has an `_index.md` entry point: read it first.

| Layer | Purpose | Trust |
|-------|---------|-------|
| `system/` | Agent runtime | Read first — write `hot.md` and `agent-log.md` only |
| `inputs/` | Incoming material | Unverified — add new files freely, ask before changing existing ones |
| `wiki/` | Verified knowledge | Write only on explicit maintainer instruction |
| `process/` | In-progress work | Free to write |
| `outputs/` | Final deliverables | Write only when maintainer confirms complete |
| `assets/raw/` | Unverified binary | Free to write |
| `assets/verified/` | Confirmed binary | Write only on explicit maintainer instruction |
| `assets/attachments/` | Working binary | Free to write |

---

## Layer rules

- `inputs/` is add-only. Create new files freely; never edit, overwrite, or
  delete an existing file there without asking — those files are source data.
- `wiki/` and `assets/verified/` are read-only by default. Write only on
  explicit maintainer instruction and a named source.
- `outputs/` is write-locked until the maintainer confirms in writing that
  the deliverable is complete.
- Never file material into a higher-trust layer to save a step.

### Promotion

**`inputs/` → `wiki/`** — trigger: maintainer names a file or topic to verify.
Read the source, cross-check against existing wiki content, write or update
the article with complete frontmatter, append one line to `agent-log.md`
citing the source path. Never promote speculatively.

**`process/` → `outputs/`** — trigger: maintainer confirms in writing the
deliverable is complete. Move the file to the right `outputs/` subfolder
(copy only if it feeds several outputs), update `outputs/_index.md`, append
one line to `agent-log.md`.

**`assets/raw/` → `assets/verified/`** — trigger: maintainer confirms the
binary is reliable. Move it, update `assets/_index.md`, log the reason.

**Backward movement** needs maintainer instruction. Log reason and date in
`agent-log.md` before moving.

### Wiki frontmatter

Every `wiki/` file needs this block. Update `updated` on every edit.

```yaml
---
title: <page title>
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: draft | verified | stable
source: <inputs/ path or URL — a list for multi-source pages>
tags: []
---
```

| Status | Meaning | Agent behaviour |
|--------|---------|-----------------|
| `draft` | Not yet cross-checked | Treat as provisional |
| `verified` | Cross-checked against an `inputs/` source | Treat as reliable |
| `stable` | Verified, unlikely to change | Treat as authoritative |

---

## Rules of engagement

### Always
- Read `system/hot.md` at session start. At session end overwrite it (the
  format is in the file) and append one line to `system/agent-log.md`:
  date, files modified, key decision.
- Present a plan and wait for confirmation before any task that touches more
  than 2 files.
- Create `_index.md` in every new folder before any other file.
- Reference file paths instead of embedding file contents.
- Preserve on every compact: modified files, key decisions, pending actions.
- Commit and push each completed change — see Git and GitHub below.
- Add new env var keys only to `.env.example`.

### Ask before
- Deleting any file or folder, or renaming a file other files reference.
- Editing or overwriting any existing file in `inputs/`.
- Adding folders not in SPEC.md section 6, or modifying `AGENTS.md` or `SPEC.md`.
- Any write to `wiki/` or `assets/verified/` — needs instruction and a named source.
- Moving a file between layers — log it in `agent-log.md`.
- Promoting `inputs/personal/` to `wiki/` or `outputs/` — confirm sharing is appropriate.

### Never
- Commit `.env`, `.claude/settings.local.json`, `.claude/hooks/hook.log`,
  `CLAUDE.local.md`, or `.obsidian/workspace.json`. All are gitignored.
- Create ad-hoc folders outside the layer structure (`docs/`, `notes/`,
  `data/`, `src/`).
- `@`-import files, except the single `@AGENTS.md` line in `CLAUDE.md` and
  `GEMINI.md`.
- Update `wiki/` or `assets/verified/` on own judgement, or move content
  backward through layers without instruction and a log entry.
- Force-push, use `--no-verify`, or push secrets.
- Print secrets — write `[REDACTED]`.

### Project-specific rules

[REPLACE: add only rules an AI tool would get wrong without being told.
Test each line: would removing it cause a mistake on this project? If no, delete it.]

---

## Sub-agents

Definitions live in `.claude/agents/` (Claude Code) and `.github/agents/`
(GitHub Copilot): one per layer plus a read-only `review-agent`. Keep scope
and constraints identical in both. Only the `tools` line of `review-agent`
differs, because the two tools name tools differently. Delete agents you do
not use.

---

## Output standards

- Headings in sentence case. File names lowercase and hyphenated.
- Folder entry point is `_index.md`, never `index.md` or `README.md`.
- Line 1 of every new file is a comment stating its purpose. No placeholder
  content, except files marked `SAMPLE`.
- Cite sources inline: `Source: [name], [date if relevant]`. Flag anything
  unconfirmed: `Unverified — needs confirmation against official docs.`
- Prefer "prefer X over Y" wording to ALL CAPS or bold for emphasis.
- Put file names, paths, and commands in backticks.
- Use markdown tables for comparisons, with a sentence-case header row.
- Separate sections with `---` and a blank line before and after.

---

## Git and GitHub

This project is a Git repository hosted on GitHub. Commit and push every
completed change — a finished task or logical unit, never mid-edit — without
asking:

1. Run `git status` and review what changed.
2. Check `git config user.email` is a GitHub noreply address
   (`<id>+<username>@users.noreply.github.com`). If not, stop and ask — a
   wrong author cannot be fixed without rewriting history.
3. Check none of the gitignored files listed under Never appear in `git status`.
   If one does, fix `.gitignore` first.
4. Update `system/agent-log.md` so the log is part of the same commit.
5. Stage changed files by name with `git add <path>`.
6. Commit as `[<type>] <short description>` — e.g. `[feat] Add wiki layer`.
   Types are in README.md. Branches are `<type>/<short-description>`.
7. Push with `git push origin <current-branch>`; use `-u` the first time.

If the push fails — no remote, rejected, or authentication error — stop and
report it. Do not retry with force. Ask before force-pushing, rewriting
history, switching or deleting branches, changing the remote, or committing
to a branch other than the current one. After a push, check the
`.github/workflows/` results.
