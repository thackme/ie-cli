#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.local/bin/ie"
if command -v ie >/dev/null 2>&1 && [[ "$(command -v ie)" != "$TARGET" ]]; then
  echo "Installation cancelled: 'ie' already exists at $(command -v ie)." >&2
  exit 1
fi
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/ie"
install -m 755 "$HERE/ie" "$TARGET"
DB="$HOME/.local/share/ie/Lab.md"
if [[ ! -e "$DB" ]]; then
  install -m 644 "$HERE/Lab.md" "$DB"
  echo 'Installed structured Lab.md database.'
elif [[ "${1:-}" == "--update-notes" ]]; then
  cp -p "$DB" "$DB.backup"
  install -m 644 "$HERE/Lab.md" "$DB"
  echo "Updated Lab.md. Previous version backed up to $DB.backup"
else
  echo "Kept existing notes: $DB"
  echo 'To install the restructured notes, run: ./install.sh --update-notes'
fi
echo 'Installed: ie'
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo 'Add to PATH: export PATH="$HOME/.local/bin:$PATH"' ;;
esac
