# Changelog

All notable changes to the TTK Kitchen Skills suite.

## [Unreleased]

### Added
- **Performance & trends** (`performance-and-trends.md`) — the metric hierarchy
  (shares/saves/follows/watch-time over likes), attribution method, and a
  ranked trend-source list (own account, peers, Google/Pinterest Trends,
  seasonality). New `trends` mode; `analyze` now ranks on growth metrics and
  tags each post by topic/ingredient/format.
- **Recipe structure** (`recipe-structure.md`) — WP Recipe Maker schema
  (grounded in the live site), the reliable create path via
  `WPRM_Recipe_Saver::create_recipe`, and API connection via WP-CLI/SSH or
  Application Passwords. `kitchen-post` now emits a structured WPRM recipe
  block so recipe drafts ship as real cards.

## [0.1.0] - 2026-09-02

First published version. Built over two sessions from a single request
("a skill for Instagram hooks") into a three-skill suite.

### Added
- **`kitchen-hooks`** — reel hooks tailored to real footage (`shoot`), account
  analysis (`analyze`), inspiration study of other accounts (`study`), and a
  drift-reporting `refresh`. Accepts a file, a folder, or a dish name; scouts
  directories and converts iPhone HEIC automatically.
- **`kitchen-post`** — a fresh blog post from a shoot, delivered on the shared
  creation-kit artifact. Net-new by default; complementary angle when a post on
  the recipe already exists. WordPress update package only on explicit request.
- **`kitchen`** — router with `full`, `guide` (checkpointed), `update`
  (rework one piece), and pass-through dispatch to the workers.
- **Shared writing floor** (`hook-writing-floor.md`) — grep-gated bans on food
  negativity, parent shaming, clinical overreach, and hype; plus the catchy
  floor requiring every hook to name its catch mechanism.
- **Measured voice profile** (`ttk-voice.md`) — derived from all 143 published
  posts (183,908 words): Canadian spellings, spaced-hyphen dash, no emoji, the
  brand vocabulary, the three proven openers, and the post skeleton.
- **Instagram data ladder** (`instagram-data.md`) — Graph API insights →
  Business Discovery → scraping, each with its provenance grade.

### Notes
- Voice corpus covers the site through 2026-07-13 (the mirror's newest post);
  refresh after the next DB import.
- Instagram caption voice not yet measured — the `analyze` mode adds it on
  first run.
- `data/` working folders are excluded from this repo by design.
