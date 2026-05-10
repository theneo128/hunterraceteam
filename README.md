# Race Control · Team Telemetry

A self-contained PWA (Progressive Web App). No backend, no build step, no
framework. Drop the folder onto a static host, open it on a phone, install
to the home screen — feels native.

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

## Deploy (free, ~30 seconds)

Pick one — all support drag-and-drop:

- **Netlify Drop** — https://app.netlify.com/drop · drag the folder, get a URL
- **Vercel** — `npx vercel` from the folder
- **GitHub Pages** — push to a repo, enable Pages on the main branch
- **Cloudflare Pages** — connect repo or upload directly

Once deployed, open the URL on your phone:

- **Android (Chrome)** — a small "Install" prompt should appear, plus
  the in-app "INSTALL" button next to "EXIT" once detected.
- **iOS (Safari)** — Apple doesn't show a prompt. Tap the share button →
  "Add to Home Screen". The in-app "INSTALL" button shows the same steps.

After install, launch from the home screen — it runs full-screen with no
browser chrome and works offline.

## Features

- F1-style start-light sequence on login
- Circular speedometer gauge tied to the daily fuel budget
- Live HH:MM:SS stint timer with wake-lock (screen stays on while running)
- Animated team race-progress bar with checkered finish
- Race-position leaderboard with gold/silver/bronze podium
- Checkered-flag celebration overlay when team hits goal
- Per-driver auto race numbers (derived from name)
- JSON export/import for cross-device team sync (no backend)
- Offline-capable, installable, dark-mode native

## Data sync without a backend

Each driver's data lives in their browser's localStorage. To play as a
team across devices, use the "Data Sync" card:

1. Driver A taps **Export Data** → gets a JSON file
2. Sends it to Driver B (AirDrop / email / Slack / etc.)
3. Driver B taps **Import Data** → merges in

The merge keeps the highest mileage per driver and unions team membership.
Existing local PINs are preserved (incoming PINs don't overwrite).

## Want a real shared backend instead?

Drop in any of these without changing the UI much:
- **Firebase Realtime Database / Firestore** — free tier, real-time sync
- **Supabase** — Postgres + auth + realtime
- **Cloudflare Durable Objects** — single-team-per-room model
- **Pocketbase** — single-binary backend, self-host anywhere

Replace the four `localStorage` calls (`getDB`, `saveDB`, plus the export
helpers) with HTTP/realtime calls and you're done.

## Customization quick-start

- Brand colors are CSS variables at the top of `index.html` (`--red`, `--green`, etc.)
- Daily-budget formula is `((mpg * tank) / 30) / 5` in the `updateDailyBudget()` function
- Mile-per-minute conversion is `5` (search `* 5`); change to fit your metaphor
- Service worker cache version: bump `'race-control-v1'` in `sw.js` to invalidate caches on deploy
