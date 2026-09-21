# SPEC.md — Project goals and technical blueprint
# Replace every marker that starts with REPLACE: with your own content before your first commit
# Project: [REPLACE: your project name]
# Repo: [REPLACE: your github repo url e.g. https://github.com/username/repo-name]
# Maintainer: [REPLACE: your github username]
# License: [REPLACE: license e.g. Apache License 2.0]
# Last updated: [REPLACE: month year]

---

## 1. Project purpose

[REPLACE: one paragraph — what this project is, what it produces, and who benefits.
Keep under 5 sentences.]

---

## 2. Target audience

- [REPLACE: audience 1 e.g. Students preparing a research report]
- [REPLACE: audience 2]

---

## 3. Core goal

[REPLACE: one sentence — the outcome this project delivers] that:

- [REPLACE: goal 1 e.g. Opens directly as an Obsidian vault]
- [REPLACE: goal 2 e.g. Lets agents file and build knowledge without guessing]
- [REPLACE: goal 3 e.g. Can be cloned from GitHub and used immediately]

---

## 4. What this project contains

| Layer / File | Purpose |
|---|---|
| `system/` | Agent runtime — session cache, change log |
| `inputs/` | All incoming material — unverified |
| `wiki/` | Verified knowledge — agent source of truth |
| `process/` | In-progress work |
| `outputs/` | Final deliverables — [REPLACE: what you produce] |
| `assets/` | Binary support material |
| `AGENTS.md` | Cross-tool AI instruction file |
| `CLAUDE.md` | Pointer to `AGENTS.md` for Claude Code |
| `GEMINI.md` | Pointer to `AGENTS.md` for Gemini CLI |
| `SPEC.md` | This file — project goals and blueprint |
| `README.md` | Human-facing overview and quickstart |
| `.claude/` | Claude Code platform config |
| `.github/` | GitHub platform config — sub-agents, workflows |
| `.obsidian/` | Obsidian vault config |

---

## 5. Success criteria

A user should be able to:

1. [REPLACE: step 1 e.g. Clone this repo from GitHub]
2. [REPLACE: step 2 e.g. Open the folder in Obsidian]
3. [REPLACE: step 3 e.g. Add material to `inputs/` and let the agent file it]
4. [REPLACE: outcome e.g. Produce a first deliverable in `outputs/`]

---

## 6. Project folder structure

This is the authoritative structure. Agents must not create folders or
files outside it without explicit maintainer instruction. Every folder
contains `_index.md` as its entry point.

```
[REPLACE: project-name]/
├── AGENTS.md                           # cross-tool agent instructions
├── CLAUDE.md                           # pointer to AGENTS.md for Claude Code
├── GEMINI.md                           # pointer to AGENTS.md for Gemini CLI
├── SPEC.md                             # this file
├── README.md                           # human-facing overview and quickstart
├── LICENSE                             # Apache License 2.0 — replace the copyright line
├── .editorconfig                       # shared editor settings
├── .env.example                        # env var keys only — never commit .env
├── .gitattributes                      # line-ending rules
├── .gitignore
├── .markdownlint.json                  # markdownlint configuration
├── .claude/
│   ├── settings.json                   # shared config — committed to Git
│   ├── settings.local.json             # personal overrides — gitignored
│   ├── agents/
│   ├── skills/
│   └── hooks/
├── .github/
│   ├── agents/
│   └── workflows/
├── .obsidian/
│   ├── app.json
│   └── workspace.json                  # gitignored — personal layout only
├── system/
│   ├── _index.md
│   ├── hot.md
│   └── agent-log.md
├── inputs/
│   ├── _index.md
│   ├── raw/
│   ├── standard/
│   └── personal/
├── wiki/
│   ├── _index.md
│   ├── synthesis/
│   ├── standard/
│   ├── clean-data/
│   └── entities/
├── process/
│   ├── _index.md
│   ├── ai-generated/
│   ├── personal/
│   └── collaborative/
├── outputs/
│   ├── _index.md
│   └── [REPLACE: subfolders — e.g. guides/, reports/, exports/]
└── assets/
    ├── _index.md
    ├── raw/
    ├── verified/
    └── attachments/
```

---

## 7. Adoption sequence

1. Create the project folder from this template and open it in Obsidian
2. Replace every `[REPLACE: placeholder]` in `AGENTS.md` and this file
3. Copy `CLAUDE.md` and `GEMINI.md` pointer files to the project root
4. Verify `.gitignore` contains `.env`, `.claude/settings.local.json`,
   and `.obsidian/workspace.json` — check manually before the first commit
5. Scaffold the folders in section 6 using the prompt in section 10
6. Connect the folder to GitHub: `git init`, set a noreply `user.email`, add the `origin` remote
7. Refine incrementally — do not finalise everything in one session

---

## 8. Key design decisions

| Decision | Rationale |
|----------|-----------|
| `AGENTS.md` as primary instruction file | Works across AI coding tools, not tool-specific |
| `CLAUDE.md` and `GEMINI.md` only point to `AGENTS.md` | One source of instructions, no drift |
| Six-layer trust model | Explicit write rules per layer, stated once in `AGENTS.md` |
| `wiki/` read-only by default | Verified knowledge must not be overwritten speculatively |
| `system/hot.md` as session cache | No persistent memory between sessions — cache restores context cheaply |
| `_index.md` as folder entry point | Tool-agnostic, Obsidian-compatible, agent-readable |
| Hook config inside `settings.json` | No separate hooks config file |
| `.env` never committed | Only `.env.example` goes to Git |
| Agent commits and pushes every completed change | Keeps the GitHub repo current and gives a step-by-step history |
| [REPLACE: your decision] | [REPLACE: your rationale] |

---

## 9. Out of scope

- [REPLACE: out of scope 1 e.g. Running agents in production]
- [REPLACE: out of scope 2]

---

## 10. Scaffold prompt

```
Please read SPEC.md section 6 and create all folders and files in that
structure exactly as listed. For each file, add a single comment on
line 1 stating its purpose. Do not create any files or folders outside
that structure. Do not proceed past planning until I confirm the plan.
```

Claude shows the plan first. Review it against section 6 before
confirming — this is your human checkpoint.

---

## 11. References

- AGENTS.md open standard: https://agents.md
- Obsidian documentation: https://help.obsidian.md
- This project: [REPLACE: your github repo url]
