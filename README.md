# Observatory

An interactive 3D map of who is building what in robotics and machine intelligence.

Open `index.html` in a browser, or serve it:

```sh
python3 -m http.server 8787
# → http://localhost:8787
```

Single self-contained file. No build step, no dependencies, no network calls.

## What the picture means

Organizations are plotted on a set of nested orbital shells.

| Visual | Encodes |
| --- | --- |
| Distance from centre | Maturity — Research, Prototype, Pilot, Production, At scale |
| Bearing | What they build — the compass is split into a Models hemisphere and a Hardware hemisphere. Companies with two distinct product lines appear once per line. |
| Diameter | Scale, 1–5 |
| Fill | Every body is filled in its category colour; shipping ones also glow |
| Hue | Category — the palette is the same wheel as the compass, so colour *is* bearing |
| Glyph | Schematic line art for the category, shown on hover and in the list |

Bearing is fixed: a body never leaves its category wedge. All motion is camera
motion, so bodies, sector dividers and labels rotate together and stay aligned.

## Views

The camera starts in **plan view** — straight down, shells flattened into concentric
circles. Drag to tilt and the shells re-incline into a woven armillary; the flattening
is driven continuously by camera pitch, so there is no mode to switch.

- **Drag** — tilt and rotate
- **Shift-drag** (or middle-drag) — pan the chart sideways
- **Scroll** — zoom, 0.25x to 14x, magnifying about the pointer
- **Touch** — one finger rotates, two fingers pinch to zoom and drag to pan, tap
  a body to open its card
- **Full screen** — hides everything but the chart
- **Reset view** — return to plan view
- **Pause** — stop rotation (it also freezes automatically while you hover a body)
- **Sound / Mute** — the ambient score, on unless you mute it
- `/` — focus search
- `n` — add an organization

## Sound

The score is generated at runtime with Web Audio — no audio files, nothing
fetched. A drone on D and its fifth sits underneath a pad that moves through
four chords, with sparse bell tones over the top, all in D minor pentatonic.

It reads the map: each bell picks a currently-visible organization and takes its
octave from that org's maturity shell, so filtering to the outer shells drops the
music lower and thins it out. Pointing at a body plays a short tone whose pitch
rises toward the centre.

Sound is on unless you mute it, and the choice is remembered.

Browsers refuse to play audio until a page has been interacted with. This is a
platform rule with no workaround available to a page, so on a normal browser the
score begins on your first click or keypress rather than at load. The page checks
whether autoplay is permitted and starts immediately where it is.

To lift the restriction locally, run `./open-with-sound.sh`. It launches Chrome
with `--autoplay-policy=no-user-gesture-required`, and sound plays with no click
at all. Chrome only reads that flag at startup and a running Chrome would ignore
it, so the script uses a separate profile directory — and therefore a separate
localStorage. Use **Export** and **Import** to carry your edits across.

## Pictures

Hovering an organization shows a **schematic glyph** for its category — a humanoid
figure, a quadruped, a gripper, a quadcopter. These are diagrams, not photographs:
drawn from primitives so they need no network and raise no licensing question.

To show a real photo instead, put a URL in an org's **Image URL** field and it
replaces the glyph, falling back to the glyph if the image fails to load. Note that
remote images work when served locally but are blocked by the artifact CSP.

Every organization's name links to its website — the ↗ at the end of each list row,
and the title in the detail pane.

The hover card is click-through until you settle on a body for a moment. Moving
between planets passes straight over it; pause and it becomes interactive, with
**Open details** and **Visit website** buttons.

## Sources

Papers, videos, and posts attach to an organization rather than existing on their own.
Select an org and use **+ Attach source**. Reading something is what tells you an org
has moved, so the detail panel has an **Advance** button to push it out a shell.

## Data

Everything lives in `localStorage` under `observatory.orgs.v1`, scoped to the origin
you serve from — changing port or browser starts you over. **Export** writes a JSON
array; **Import** merges by name and skips duplicates. Keep an export around.

## The seed data is a first draft

The file ships with 66 organizations as a starting point. Maturity placements are
judgment calls made against a January 2026 knowledge cutoff, in a field that moves
monthly. Treat it as something to argue with and correct in place — particularly the
humanoid companies, where public information was thin and changing fast.
