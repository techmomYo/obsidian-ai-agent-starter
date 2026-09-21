#!/bin/bash
# pre-tool-check.sh — logs tool name and file path before a Write or Edit, never blocks
# Triggered by: PreToolUse hook in .claude/settings.json
# The log (hook.log, gitignored) holds no file contents.

input=$(cat)
tool=$(printf '%s' "$input" | grep -o '"tool_name": *"[^"]*"' | head -1 | cut -d'"' -f4)
file=$(printf '%s' "$input" | grep -o '"file_path": *"[^"]*"' | head -1 | cut -d'"' -f4)
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) pre ${tool:-unknown} ${file:-none}" >> "$(dirname "$0")/hook.log"
exit 0
