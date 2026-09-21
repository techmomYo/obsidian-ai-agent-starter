# Purpose: entry point for system/ — agent runtime layer — session cache and change log

---

Read first every session. Agents may write `hot.md` and `agent-log.md` only.

| File | Role |
|------|------|
| `hot.md` | Session cache — overwrite at session end |
| `agent-log.md` | Append-only change log — one line per change |
