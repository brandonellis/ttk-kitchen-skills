# Changelog

All notable changes to the TTK Kitchen Skills suite.

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
