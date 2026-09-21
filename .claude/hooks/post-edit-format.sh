#!/bin/bash
# post-edit-format.sh — logs tool name and file path after a Write or Edit, never blocks
# Triggered by: PostToolUse hook in .claude/settings.json
# To format files, add a formatter call here (e.g. prettier --write "$file").

input=$(cat)
tool=$(printf '%s' "$input" | grep -o '"tool_name": *"[^"]*"' | head -1 | cut -d'"' -f4)
file=$(printf '%s' "$input" | grep -o '"file_path": *"[^"]*"' | head -1 | cut -d'"' -f4)
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) post ${tool:-unknown} ${file:-none}" >> "$(dirname "$0")/hook.log"
exit 0
