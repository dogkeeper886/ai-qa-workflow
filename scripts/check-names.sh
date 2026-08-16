#!/bin/sh
# Find a citation of a skill that no longer exists.
#
# A rename leaves citations behind across the skills, the manifests and the
# README, and each one reads correctly on its own, so nothing catches them by
# eye. This does.
#
# Usage:  scripts/check-names.sh            # the plugin, the README, CLAUDE.md
#         scripts/check-names.sh <path>     # one file or directory
#
# Exit 0 = clean, 1 = at least one citation that does not resolve.
#
# THE RULE, in three parts, because a regex alone cannot carry it:
#
#   1. A citation is a hyphenated lowercase token written in backticks or after
#      a slash — `land-pr` or /land-pr — and not followed by a dot or a slash,
#      which would make it a filename or a path rather than a name.
#
#   2. It resolves if a directory of that name exists under skills/, or it is
#      the name of a plugin in the marketplace. Both sets are read from the
#      tree, so this script does not go stale when a skill is added or renamed.
#
#   3. Anything else that is unit-shaped and is not a unit is listed in
#      NOT_A_UNIT below, one line each, with the reason. A list you can read
#      beats a prefix whitelist you cannot: the checker this replaced matched
#      only the prefixes gen|review|reviewing|reporting|ship|setup|doc, so it
#      was blind to open-pr, land-pr, do-task, take-issue, file-issue and
#      plan-work — six of the fourteen skills it was meant to protect.
#
# The two remove lists are exempt. Naming retired units is their job.

set -eu

ROOT=$(git rev-parse --show-toplevel)
SKILLS="$ROOT/plugins/agent-workflows/skills"
EXEMPT="$SKILLS/remove-stale-files"

# Unit-shaped, not a unit. Add a line here rather than widening the regex.
NOT_A_UNIT="
agent-workflows          the plugin, not a skill
agent-workflows-runner   a separate plugin
allowed-tools            a skill frontmatter key
claude-code              the product
in-progress              part of a status label
other-repo               a placeholder in an example
rsvg-convert             an external command
"

if [ $# -gt 0 ]; then
  TARGETS="$1"
else
  TARGETS="$ROOT/plugins $ROOT/.claude-plugin $ROOT/README.md $ROOT/CLAUDE.md"
fi

HITS=$(mktemp)
trap 'rm -f "$HITS"' EXIT

# Names that resolve: a skill directory, or a plugin in the marketplace.
VALID=$(
  ls "$SKILLS"
  sed -n 's/.*"name": "\([a-z0-9-]*\)".*/\1/p' "$ROOT/.claude-plugin/marketplace.json"
)

# -H so a single-file target still prints its path; -P for the lookaround that
# keeps `/agent-workflows:file-issue` from swallowing the skill half.
# shellcheck disable=SC2086
grep -rnHoIP '(?<=[/`:])[a-z][a-z0-9]*(?:-[a-z0-9]+)+(?![a-z0-9./-])' $TARGETS 2>/dev/null \
| awk -F: '{ printf "%s:%s\t%s\n", $1, $2, substr($0, length($1) + length($2) + 3) }' \
| while IFS="$(printf '\t')" read -r loc name; do
    case "$loc" in "$EXEMPT"*) continue ;; esac
    printf '%s\n' "$VALID" | grep -qx "$name" && continue
    printf '%s\n' "$NOT_A_UNIT" | grep -q "^$name  " && continue
    printf '%s  ->  %s\n' "${loc#"$ROOT"/}" "$name (no such skill)"
  done | sort -u >> "$HITS"

cat "$HITS"
count=$(grep -c . "$HITS" || true)
echo
if [ "$count" -eq 0 ]; then
  echo "clean"
  exit 0
fi
echo "$count citation(s) that do not resolve"
exit 1
