#!/bin/sh
# Locate the mechanical AI-writing tells in a document.
#
# These are CANDIDATES, not findings. A hit costs the reader or it does not,
# and only judgment decides which — see SKILL.md. What this buys is that the
# searching stops depending on the model's mood: the same file gives the same
# counts on every run, on every model.
#
# Exits 0 even with hits, deliberately. It locates; it does not grade.
#
# Usage:  check-prose.sh <file>...

set -u
[ $# -eq 0 ] && { echo "usage: check-prose.sh <file>..." >&2; exit 2; }

for F in "$@"; do
  [ -f "$F" ] || { echo "no such file: $F" >&2; continue; }
  echo "══ $F"

  # ---- symbols: one character, exact ------------------------------------
  # Straight from the symbol table. Each is a character an editor does not
  # produce by accident.
  echo "-- symbols"
  # grep -c already prints 0 and exits 1; a `|| echo 0` would print it twice
  sym() { n=$(grep -c "$1" "$F" 2>/dev/null); [ "${n:-0}" -gt 0 ] && printf '  %-22s %3d   %s\n' "$2" "$n" "$3"; }
  sym '—'        'em dash'          'the most-cited tell — comma, colon, or full stop'
  sym '–'        'en dash'          'hyphen in a range, full stop otherwise'
  sym ' - '      'spaced hyphen'    'an em dash in disguise'
  sym '…'        'ellipsis'         'it continues or it does not'
  sym '“\|”'     'curly quote'      'straight quotes only'
  sym '’'        'curly apostrophe' 'straight apostrophe only'
  sym '•'        'bullet char'      'use a real list'
  sym '→'        'arrow'            'write the word'
  sym '!'        'exclamation'      'technical prose states, it does not exclaim'
  # Emoji. ✓ and ✗ are excluded: deliberate in a diagram or a table, not decoration.
  # grep -P is GNU-only. On BSD and macOS it is absent, and a suppressed error there
  # would report "no emoji" on a file full of them, which is worse than not checking.
  # So probe once, fall back to literal matching, and say which ran.
  if echo x | grep -qP 'x' 2>/dev/null; then
    hits=$(grep -nP '[\x{1F300}-\x{1FAFF}\x{2705}\x{274C}\x{26A0}\x{2728}\x{2764}]' "$F" 2>/dev/null)
    how='full unicode range'
  else
    hits=$(grep -nF -e '✅' -e '❌' -e '⚠' -e '✨' -e '❤' -e '🎉' -e '🚀' -e '💡' -e '🔥' -e '📌' "$F" 2>/dev/null)
    how='common set only — no grep -P on this system'
  fi
  if [ -n "$hits" ]; then
    total=$(printf '%s\n' "$hits" | wc -l)
    printf '  %-22s %3d   %s\n' 'emoji' "$total" "$how"
    # Five lines is enough to show the pattern; the count above is the real number,
    # printed first so a truncated list is never mistaken for the whole of it.
    printf '%s\n' "$hits" | head -5 | sed 's/^/    /'
    [ "$total" -gt 5 ] && printf '    ... and %d more\n' $((total - 5))
  fi

  # ---- em dash as a RATE, which presence alone cannot show --------------
  words=$(wc -w < "$F")
  dashes=$(grep -o '—' "$F" 2>/dev/null | wc -l)
  [ "$words" -gt 0 ] && [ "$dashes" -gt 0 ] && \
    printf '  %-22s %3d per 1000 words\n' 'em-dash rate' $(( dashes * 1000 / words ))

  # ---- terms: literal, any casing, whole word ---------------------------
  echo "-- terms"
  term() {
    hits=$(grep -inoE "\\b($1)\\b" "$F" 2>/dev/null | wc -l)
    [ "$hits" -gt 0 ] && printf '  %-14s %3d   %s\n' "$2" "$hits" "$3"
  }
  # inflated: the plain word exists and is shorter
  term 'utilise|utilize|leverage|harness' 'inflated:use'    'write use'
  term 'facilitate'                       'inflated'        'write help, or name what it does'
  term 'commence'                         'inflated'        'write start'
  term 'demonstrate|showcase|underscore'  'inflated:show'   'write show'
  term 'delve'                            'inflated'        'write examine, or name the step'
  term 'robust|comprehensive|holistic'    'inflated:claim'  'name what is covered, not its quality'
  term 'seamless|seamlessly|streamline'   'inflated'        'name the observable result'
  term 'cutting-edge|groundbreaking|game-changer|transformative|unleash' 'marketing' 'not a technical claim'
  term 'paradigm|tapestry|realm|landscape|testament|ecosystem' 'rhetoric' 'name the thing itself'
  term 'meticulous|multifaceted|nuanced'  'inflated'        'name the detail or drop it'
  term 'pivotal|crucial|vital'            'inflated'        'name why it matters, or drop it'
  term 'empower|elevate|bolster'          'inflated'        'name the change'
  # filler: carries nothing
  term 'very|really|extremely|incredibly' 'filler'          'cut it, or give the number'
  term 'basically|essentially|simply|just' 'filler'         'cut it'
  term 'clearly|obviously'                'filler'          'if it is, it needs no saying'
  term 'significantly|notably|importantly|interestingly' 'filler' 'give the number, or cut'
  # openers and transitions: the shape of generated prose
  term 'moreover|furthermore|additionally' 'opener'         'start with the point'
  term 'in conclusion|at the end of the day' 'opener'       'cut it'
  term "it'?s important to note|it is worth noting|let'?s dive in" 'opener' 'cut it and state the thing'
  term "in today'?s|when it comes to|in the realm of" 'opener' 'name the subject directly'
  # contrast frames: the fixed half of "not X, it's Y"
  term "not just|not only|here'?s the thing|this is where" 'contrast-frame' 'state what it is'
  # hedges
  term 'arguably|generally|typically|somewhat|relatively|fairly' 'hedge' 'state the claim, or name what it varies with'
  term 'may help|can often|might potentially' 'hedge'       'state the claim'
  # technical-document specific: a quality adjective standing in for a result
  term 'successfully|properly|correctly|as expected' 'unobservable' 'name the observable result'
  term 'appropriate|various|etc'          'vague'           'name it, or give the count'
  term 'verify that|ensure that'          'qa-filler'       'name what is checked, not that it is checked'
  # rot: relative time goes stale on its own
  term 'currently|recently|nowadays|at this time' 'relative-time' 'write the condition, e.g. "in v2.3 and later"'

  echo
done
exit 0
