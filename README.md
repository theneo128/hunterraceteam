# Ride Tracker

A simple PWA for tracking how long each kid rides their battery cars and
pedal cars around the house. Pick a tile, hit Start Ride, hit Stop when
they're done. See who's ridden the most today, set per-kid daily limits,
and the app warns when the limit's hit.

No backend, no build step, no framework — drop the folder onto a static
host, open it on a phone, install to the home screen, and it works
offline.

## What's in this folder

```
index.html              The app
manifest.json           Web App Manifest (installability)
sw.js                   Service Worker (offline support)
icon-192.png            PWA icon
icon-512.png            PWA icon
icon-512-maskable.png   Adaptive icon (Android round masks)
apple-touch-icon.png    iOS home-screen icon
favicon.png             Browser tab icon
```

## Run locally

PWAs need a real HTTPS (or localhost) origin — they won't fully work from
`file://`. Easiest way:

```bash
# Python
python3 -m http.server 8080

# Node
npx serve .
```

Then visit `http://localhost:8080`.

## Deploy

Pick whatever:

- **GitHub Pages** — Settings → Pages → Source: main / root → Save
- **Netlify Drop** — drag the folder, get a URL
- **Vercel** — `npx vercel` from the folder
- **Cloudflare Pages** — connect repo or upload directly

Once deployed, open the URL on the phone:

- **Android (Chrome)** — tap the install button (⬇) in the top-right.
- **iOS (Safari)** — tap the install button → step-by-step "Add to Home
  Screen" instructions appear.

After install, launch from the home screen — runs full-screen, works
offline.

## Features

- Tap-to-pick rider tiles (no PIN, kid-friendly)
- One starter rider seeded automatically (Hunter); add more from the
  picker
- Each rider has a color and shows up on their tile and leaderboard
- Big Start / Stop button — wake-lock keeps the screen on while a ride
  is running
- Per-rider daily limit (default 30 min) — bar turns yellow at 75%, red
  when over, and a "Time's up!" toast appears the moment you cross
- Today / All Time leaderboard with medal emoji 🥇🥈🥉
- "Edit riders" mode in the picker → remove rider with confirmation
- Cross-device sync via JSON Export / Import (AirDrop, email, etc.)
- Offline-capable, installable, light cream theme

## Daily reset

Each rider tracks `todayMinutes` and `todayDate`. When the date rolls
over, today's count resets automatically (the all-time total keeps
adding up).

## Data sync without a backend

Each device's data lives in browser localStorage. To sync between
phones / tablets:

1. On device A: tap **📤 Export** → gets a JSON file
2. Send it (AirDrop / Slack / email)
3. On device B: tap **📥 Import** → merges in

Merge rules: keeps the higher all-time minutes per rider; if the same
day is open on both, keeps the higher today count.

## Customization

- Theme colors live as CSS variables at the top of `index.html`
  (`--bg`, `--green`, `--red`, etc.)
- Default daily limit is `30` (search `dailyLimitMinutes: 30`)
- Rider color palette is `RIDER_COLORS` in the script
- Service worker cache version: bump `'ride-tracker-v3'` in `sw.js` to
  invalidate caches on next deploy
