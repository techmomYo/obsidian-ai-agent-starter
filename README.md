<!-- README.md — human-facing overview, quickstart, and replace checklist for the starter -->
# obsidian-ai-agent-starter

A starter template for any Obsidian + AI agent project. It gives you a
six-layer folder structure with a defined trust level per layer, so an
agent knows where it may read, write, and promote material without
asking. Copy it, open it in Obsidian, replace the marked values, and you
have an agent-ready workspace.

Built with Claude Code. It is designed for other tools that read
`AGENTS.md` (Cursor, GitHub Copilot, Gemini CLI), but that has not been
tested.

---

## The six layers

| Layer | Purpose | Agent write access |
|-------|---------|--------------------|
| `system/` | Agent runtime — session cache, change log | `hot.md` and `agent-log.md` only |
| `inputs/` | Incoming material, unverified | Add-only — existing files need approval |
| `wiki/` | Verified knowledge, the agent's source of truth | Maintainer instruction and a named source |
| `process/` | In-progress work | Free |
| `outputs/` | Final deliverables | Only when the maintainer confirms completion in writing |
| `assets/` | Binary support material | `raw/` and `attachments/` free, `verified/` on instruction |

Material moves up one layer at a time: `inputs/` to `wiki/`, and
`process/` to `outputs/`. The rules are in `AGENTS.md`.

---

## Quickstart

1. Click **Use this template** on GitHub, or copy this folder to a new
   project folder.
2. Open the folder in Obsidian (**Open folder as vault**).
3. Replace every `REPLACE:` marker using the checklist below.
4. Delete the three `sample-*.md` files once you have added your own.
5. Connect the folder to your GitHub repo (see Git and GitHub below).
6. Open your AI tool in the folder and give it your first task. It reads
   `system/hot.md` at the start of each session.

---

## Replace checklist

Every value you must change is written as `[REPLACE: what goes here]`.
List the ones still left with:

```bash
grep -rnE "REPLACE:|SAMPLE" --exclude-dir=.git .
```

On Windows PowerShell, which has no `grep`:

```powershell
Get-ChildItem -Recurse -File -Force | Where-Object { $_.FullName -notmatch '\\\.git\\' } | Select-String -CaseSensitive -Pattern 'REPLACE:|SAMPLE'
```

| File | Replace |
|------|---------|
| `AGENTS.md` | Project name, overview paragraph, your own project-specific rules |
| `SPEC.md` | Project name, repo URL, maintainer, purpose, audience, goals, structure, decisions |
| `README.md` | Everything above the checklist, so it describes your project |
| `LICENSE` | Year and copyright holder on the last lines |
| `.env.example` | Values for the keys your project uses |
| Git config | `user.email` (your GitHub noreply address) and the `origin` remote URL |
| `system/hot.md`, `system/agent-log.md` | The `REPLACE:` entries, on your first session |
| `outputs/_index.md` | Your output subfolders |
| `inputs/raw/sample-web-clip.md` | Rename to your first source, or delete |
| `wiki/synthesis/sample-article.md` | Rename to your first article, or delete |
| `process/ai-generated/sample-draft.md` | Rename to your first draft, or delete |

Keep these as they are: `CLAUDE.md` and `GEMINI.md` only point to
`AGENTS.md`, so you do not edit them.

---

## What is in the repo

```
AGENTS.md          single source of AI instructions
CLAUDE.md          pointer to AGENTS.md for Claude Code
GEMINI.md          pointer to AGENTS.md for Gemini CLI
SPEC.md            project goals and folder structure
.claude/           settings, sub-agents, hook scripts
.github/           sub-agents for GitHub Copilot, markdown lint workflow
.obsidian/         shared Obsidian vault settings
system/  inputs/  wiki/  process/  outputs/  assets/
```

Every folder has an `_index.md` explaining what belongs there.

---

## Git and GitHub

The project is built to live in a GitHub repo. `AGENTS.md` tells the
agent to commit and push after every completed change, using the
`[<type>] <short description>` format below.

Set up once, before the first session:

```bash
git init -b main
git config user.email "[REPLACE: id+username@users.noreply.github.com]"
git remote add origin https://github.com/[REPLACE: username]/[REPLACE: repo-name].git
```

Create the empty repo on GitHub first. Use the noreply address so your
private email never appears in the commit history.

This behaviour is an instruction to the agent, not something Git
enforces. `.claude/settings.json` allows `git add`, `git commit` and
`git push`, and denies force-push and `--no-verify`. Remove those
`git` permissions and the "Git and GitHub" section of `AGENTS.md` if you
prefer to commit by hand.

Tool permissions such as these are conveniences, not security boundaries:
the agent can still phrase a command in a way a rule does not match. The
instructions in `AGENTS.md` (no force-push, no `--no-verify`, no secrets in
commits) are the backstop, so review what the agent pushes.

---

## Sub-agents

Six agents, one per layer plus a read-only reviewer. The same files are in
`.claude/agents/` (Claude Code) and `.github/agents/` (GitHub Copilot).
Keep the two in sync — only the `tools` line of `review-agent` differs,
because the two tools name tools differently. Copilot custom agents are in
public preview in some IDEs, so their behaviour may change. Delete any you do
not use.

| Agent | Scope |
|-------|-------|
| `system-agent` | `system/` |
| `inputs-agent` | `inputs/` |
| `wiki-agent` | `wiki/` |
| `process-agent` | `process/` |
| `outputs-agent` | `outputs/` |
| `review-agent` | Read-only, all layers |

---

## Hooks

`.claude/hooks/` holds two example scripts that log the tool name and file
path of each write or edit to `.claude/hooks/hook.log`. They run because
`.claude/settings.json` wires them to `Write` and `Edit`. The log holds no
file contents and is gitignored. On Windows they need Git Bash. Delete the
`hooks` block in `settings.json` if you do not want them.

---

## Security

- Never commit `.env`, `.claude/settings.local.json`,
  `.claude/hooks/hook.log`, or `.obsidian/workspace.json`. They are
  already in `.gitignore` — check it before your first commit.
- Only `.env.example` goes to Git.
- `~/.claude.json` holds OAuth tokens — never commit or share it.

---

## Commit conventions

**Branch:** `<type>/<short-description>`
**Commit:** `[<type>] <short description>`

| Type | Use for |
|------|---------|
| `feat` | New folder, file, or capability added |
| `fix` | Correcting an error in existing content |
| `docs` | Documentation updates |
| `refactor` | Restructuring without changing content |
| `chore` | Maintenance — gitignore, config, formatting |

Examples: `feat/add-wiki-layer` · `[feat] Add wiki layer with entities subfolder`

---

## Output style

| Element | Rule | Example |
|---------|------|---------|
| Headings | Sentence case | `## Project structure decisions` |
| File names | Lowercase hyphenated | `setup-guide.md` |
| Folder entry | Always `_index.md` | not `README.md` or `index.md` |

---

## About this repo

The structure and rules were set by the maintainer. Claude (Anthropic) wrote
the files from those instructions, the design was cross-referenced with other
AI tools, and the technical claims were checked against the official Claude
Code, Gemini CLI, and GitHub Copilot documentation. It is AI-generated
content: check it against current documentation before you rely on it, and
report errors as issues.

Not affiliated with or endorsed by Anthropic, Google, GitHub, Cursor, or
Obsidian. Product names are used only to say what the files work with.

---

## License

Apache License 2.0 — see `LICENSE`.

---

## References

- [AGENTS.md open standard](https://agents.md)
- [Claude Code documentation](https://code.claude.com/docs)
- [Obsidian help](https://help.obsidian.md)
