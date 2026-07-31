#!/usr/bin/env bash
set -euo pipefail

REPOSITORY_RAW_URL="${OPENGGOO_SKILL_BASE_URL:-https://raw.githubusercontent.com/MSNirvana/Open_GGOO/main}"
TARGET=""
TARGET_DIR=""

usage() {
  echo "Usage: install.sh --target <codex|gemini|copilot|opencode|agents|claude>"
  echo "       install.sh --dir <absolute-skill-directory>"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target) TARGET="${2:-}"; shift 2 ;;
    --dir) TARGET_DIR="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ -n "$TARGET" ] && [ -n "$TARGET_DIR" ]; then
  echo "Use either --target or --dir, not both." >&2
  exit 2
fi

if [ -z "$TARGET" ] && [ -z "$TARGET_DIR" ]; then
  usage
  exit 2
fi

if [ -n "$TARGET" ]; then
  case "$TARGET" in
    codex|gemini|copilot|opencode|agents) TARGET_DIR="$HOME/.agents/skills/openggoo" ;;
    claude) TARGET_DIR="$HOME/.claude/skills/openggoo" ;;
    *) echo "Unsupported target: $TARGET" >&2; exit 2 ;;
  esac
fi

case "$TARGET_DIR" in
  /*) ;;
  *) echo "--dir must be an absolute path." >&2; exit 2 ;;
esac

parent_dir=$(dirname "$TARGET_DIR")
mkdir -p "$parent_dir"
work_dir=$(mktemp -d "$parent_dir/.openggoo-install.XXXXXX")
stage_dir="$work_dir/openggoo"
backup_dir="$work_dir/previous"
mkdir -p "$stage_dir/agents" "$stage_dir/assets" "$stage_dir/references"

cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

curl -fsSL "$REPOSITORY_RAW_URL/manifest.sha256" -o "$work_dir/manifest.sha256"
while read -r expected file; do
  [ -n "$expected" ] || continue
  case "$file" in
    SKILL.md|LICENSE|agents/openai.yaml|assets/logo.png|references/api.md|references/mcp.md|references/sync.md|references/errors.md) ;;
    *) echo "Unexpected manifest entry: $file" >&2; exit 4 ;;
  esac
  mkdir -p "$stage_dir/$(dirname "$file")"
  curl -fsSL "$REPOSITORY_RAW_URL/$file" -o "$stage_dir/$file"
  actual=$(shasum -a 256 "$stage_dir/$file" | awk '{print $1}')
  if [ "$actual" != "$expected" ]; then
    echo "Checksum mismatch: $file" >&2
    exit 4
  fi
done < "$work_dir/manifest.sha256"

grep -q '^name: openggoo$' "$stage_dir/SKILL.md" || {
  echo "Invalid Skill identity." >&2
  exit 4
}

if [ -e "$TARGET_DIR" ]; then
  mv "$TARGET_DIR" "$backup_dir"
fi
if ! mv "$stage_dir" "$TARGET_DIR"; then
  [ -e "$backup_dir" ] && mv "$backup_dir" "$TARGET_DIR"
  exit 5
fi
rm -rf "$backup_dir"

echo "Open GGOO Skill installed at $TARGET_DIR"
echo "Open a new Agent session, then ask: 现在最热的 5 个 AI 开源项目是什么？"
