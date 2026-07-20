#!/bin/sh
# Launch Observatory in a Chrome instance that allows audio without a click.
#
# Chrome only reads --autoplay-policy at startup, and a running Chrome would
# just open a tab in the existing process and ignore it. So this uses its own
# profile directory — which means its own localStorage, separate from your
# normal browser. Use Export / Import to carry your edits across.
PORT="${PORT:-8787}"
PROFILE="$HOME/.observatory-chrome"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

[ -x "$CHROME" ] || { echo "Chrome not found at $CHROME"; exit 1; }
curl -sf -o /dev/null "http://localhost:$PORT/" || {
  echo "Nothing serving on port $PORT. Start it with:"
  echo "  cd ~/observatory && python3 -m http.server $PORT"
  exit 1
}

exec "$CHROME" \
  --user-data-dir="$PROFILE" \
  --autoplay-policy=no-user-gesture-required \
  --new-window "http://localhost:$PORT/"
