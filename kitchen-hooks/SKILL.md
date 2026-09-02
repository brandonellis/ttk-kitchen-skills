---
name: kitchen-hooks
description: Analyze @thetoddlerkitchen's Instagram reels to learn which hooks perform for THIS account, then write food-positive hooks for new content. Use when the user asks for Instagram hooks, reel hooks, captions, cover text, "why did this reel do well/poorly", wants hooks for freshly shot food photos/video, or wants to study another account's content for inspiration ("look at this account", "why do their reels work"). Never negative about food — Alison is a registered dietitian.
argument-hint: "[shoot <media-path-or-dish> · analyze · study <@acct> · trends · refresh · help] — no args runs analyze then builds the hook bank"
disable-model-invocation: false
---

# /kitchen-hooks — evidence-based hooks for The Toddler Kitchen

Part of the `/kitchen` suite (with `/kitchen-post`): one creation, one
artifact. Reachable as `/kitchen instagram …` or `/kitchen full …`.

Learn from @thetoddlerkitchen's own reels which openings earn attention, then
write hooks a registered dietitian would happily say on camera. Two hard
identities shape every output:

1. **The account is Alison's professional presence.** She is a registered
   dietitian. Every hook must survive her saying it to a peer RD. No food
   negativity, no parent shaming, no claims she couldn't defend clinically.
   The full rules live in `references/hook-writing-floor.md` — load it before
   writing ANY hook, caption, or analysis prose, and run its grep gates on the
   finished output. Captions and on-screen text also follow the measured site
   voice in `references/ttk-voice.md` (Canadian spellings, spaced-hyphen dash,
   no emoji, the brand vocabulary); spoken hook lines may be punchier but
   never break its mechanics.
2. **Evidence beats instinct.** Hook patterns are graded by what this account's
   numbers actually show, not by generic growth advice. Numbers are sourced,
   never invented (see "Provenance grades" below).

Read-only on Instagram, always: never like, comment, follow, DM, or post.

## Modes (from args)

| Args | Mode | What it does |
|---|---|---|
| *(none)* | full run | Analyze the account (below), then build/update the hook bank. If a recent snapshot exists (< 30 days), offer to reuse it instead of re-scraping. |
| `shoot <path or dish>` | tailored hooks | The main working mode once analysis exists: hooks for a specific piece of freshly shot content. See "Shoot mode". |
| `analyze` | analysis only | Scrape + classify + pattern report, no hook bank. |
| `study <@account …>` | inspiration study | Learn from accounts we like: pull their recent reels via the acquisition ladder in `references/instagram-data.md`, rank against that account's own median, transcribe the top hooks, extract mechanisms into the swipe file. See "Study mode". |
| `trends [ingredient/topic …]` | trend read | What to make next: cross-reference the account's own top-quartile topics, peer signal, and free external demand (Google Trends, Pinterest Trends, seasonality). See "Trends mode". |
| `refresh` | drift report | Re-pull public numbers, diff against the last snapshot. See "Refresh is a drift report". |
| `help` | show the modes | Print this table with one-line examples and stop. Also the right response to any argument matching no mode: show the table and ask, never guess. |

## Provenance grades (numbers are sourced, never invented)

Every number and every "why" claim carries its grade, and the grades render
differently in output:

1. **Measured** — from Instagram Insights the user provides (screenshots or
   exports): reach, retention, saves, shares, follows-from-post. The only
   source that can say *where viewers dropped off*.
2. **Public** — scraped from the public profile: reel play counts, likes,
   comments, post dates. Real but shallow; a play count can't distinguish a
   great hook from a lucky share.
3. **Inferred** — your judgment about WHY something worked. Always written as
   hypothesis ("the three winners all open on the finished plate, which
   suggests…"), never as fact. An inferred cause must never resurface later as
   a measured one.

If a needed number can't be sourced, say so plainly — a gap is a finding, not
a blank to fill.

## Phase 1 — gather evidence (scan first, ask second)

1. **Prior work first**: check `data/` in this skill directory for snapshots
   and an existing `hook-bank.md`. If a snapshot exists, the default is to
   build on it, not restart.
2. **Pull the account's reels via the acquisition ladder** in
   `references/instagram-data.md`: if the Graph API token exists
   (`~/.config/ttk/ig-token`), use it — media list + per-reel insights
   upgrades the whole run to Measured. Otherwise scrape with the `/browse`
   skill (never Chrome MCP tools): open
   `https://www.instagram.com/thetoddlerkitchen/reels/` and
   collect, for the most recent ~30 reels: permalink, play count, post date,
   cover text if legible. Then open the top and bottom performers individually
   for likes, comments, caption first line, and a description of the first
   1–3 seconds (the visual hook). Confirm on first run that this handle is
   Alison's account before analyzing anything.
   - **User-provided Insights are a first-class input, not a last resort.**
     Screenshots or exports of the account's own Insights (reach, saves,
     shares, follows, watch time) are the fastest route to Measured and are
     often the ONLY working path — the Graph token may not be set up and the
     public grid is frequently login-walled. Offer this up front. If scraping
     is the only option and it hits a wall, suggest `/setup-browser-cookies`
     once, then ask for screenshots. Never retry aggressively.
3. **One round of questions** (AskUserQuestion), only for real gaps — the
   standing ones: can the user export or screenshot Instagram Insights for the
   top/bottom ~5 reels (upgrades the whole analysis to Measured), and is there
   anything Alison has already decided about voice or topics that isn't
   written down anywhere? Skip the round entirely if the user already provided
   these; never block on it.
4. **Snapshot everything** to `data/snapshot-YYYY-MM-DD.json` (date from
   `date +%F`): one record per reel with url, date, the metrics (play count,
   likes, comments, and — with the API token — saves, shares, reach,
   follows, watch time), caption first line, hook description, and the
   grade of each field. Also tag each record `{topic, primary_ingredients,
   format, hook_pattern, season}` so trends can be sliced by one field at a
   time (see `references/performance-and-trends.md`). Snapshots are what make
   `refresh`, trend analysis, and longitudinal learning possible.

## Phase 2 — analyze (the account is its own baseline)

- **Rank by the right metric, not by likes.** Load
  `references/performance-and-trends.md` first. With the API token, rank on
  shares + saves + follows (the growth signals); without it, rank on the best
  public proxy available (usually plays, then likes) and say so. Likes are
  never the target.
- **Classify against the account's own median, never against other accounts.**
  Top quartile = winners, bottom quartile = laggards on the chosen metric.
  Recency-adjust: a 3-day-old reel at median is outperforming, not average.
- **Transcribe the hook of every winner and laggard**: spoken first line,
  on-screen text, first visual, caption first line. The hook is all four
  together.
- **Extract patterns, not posts.** Cluster into named hook patterns (e.g.
  relatable-scene, curiosity-gap, direct-value, credential-led, gentle
  myth-reframe) with the evidence refs (reel links) behind each. A pattern
  needs ≥2 examples to be a pattern; one hit is an anecdote and is labeled as
  one.
- **Laggards are experiments, never failures.** Frame every underperformer as
  discipline-plus-gap: what the post did deliberately, plus the specific gap
  the numbers suggest ("the recipe is strong; the first two seconds show a
  static pan, and nothing on screen says why to stay"). Never blame Alison,
  never trash the food, never write a sentence about a laggard she would be
  hurt to read — she may see this report.
- **Separate content from hook.** A laggard might be a topic issue, a timing
  issue, or a hook issue; only claim "hook problem" when the same topic
  performed elsewhere with a different opening.

Output of this phase: a pattern report — winners' shared patterns, laggards'
shared gaps, each claim carrying its provenance grade — plus `hook-bank.md`
in `data/`: 12–20 ready hooks grouped by proven pattern, each tagged with the
evidence refs that earned that pattern its place.

Also on the first run: derive the **caption voice** from the account's own
captions (emoji habits, typical length, hashtag conventions, CTA phrasing,
how captions differ from the blog register) and add it to
`references/ttk-voice.md` as a "Caption voice" section — the blog corpus
can't supply this, only the account can.

## Shoot mode — hooks tailored to fresh footage

Run after photos/video of a dish are taken, so hooks match what's actually on
camera. The first second of a reel must agree with its first frame.

`shoot` accepts a **file, a directory, or a dish name**. Given a directory
(or a vague pointer like "my latest photos"), scout it first:

- Inventory images and video (`jpg/jpeg/png/webp/heic/mp4/mov`,
  case-insensitive), newest first. Group into candidate shoots by filename
  stem and capture-time proximity (files within ~2 hours of each other are
  usually one shoot).
- Present the groups as a short table (name guess, file count, date) and
  confirm which one to run — one question, only when more than one group
  plausibly matches.
- **HEIC (iPhone) files**: Read can't open them — convert first to the
  scratchpad (`sips -s format jpeg photo.heic --out scratch/photo.jpg`).
  Same for video frames via ffmpeg.
- Known standing location: `wp-content/uploads/YYYY/MM/` (the prod media
  mirror). Other standing photo folders Brandon names get recorded in the
  `/kitchen` router's "Media locations" list — check there first.

1. **Look at the media.** Photos: Read them directly. Video: extract frames to
   the scratchpad (`ffmpeg -i in.mp4 -vf fps=1 frames_%02d.jpg`, first ~8
   frames) and Read those; if ffmpeg is missing, ask for a few stills instead.
   Note what is genuinely on screen: the dish, the setting, hands/kid
   presence, texture moments (pull-apart, steam, dip), the strongest single
   frame.
2. **Load the evidence.** Read the latest pattern report and `hook-bank.md`.
   No analysis yet? Say so, offer to run it, and if the user declines write
   hooks from the writing floor's pattern list, labeled Inferred throughout.
3. **Write 5–8 hook options**, each a complete package: spoken opening line,
   on-screen text overlay, caption first line, suggested cover frame (from the
   actual frames you saw), the proven pattern it draws from with its
   evidence ref, and the **catch mechanism** it uses (curiosity gap, vivid
   specific, twist, or claimed payoff — see the catchy floor in the writing
   floor; a hook that can't name one isn't done). Lead with the option the
   evidence best supports and say why in one sentence.
4. **Gate the output** with the writing-floor greps before presenting.

## Study mode — learning from accounts we like

Other accounts are pattern mines, never source material. For each named
account (data via the acquisition ladder in `references/instagram-data.md`:
Graph API Business Discovery when the token exists, `/browse` scraping as
the restrained fallback, and **user-shared links/screenshots — often the only
working path today, so ask for them up front**):

1. Rank their recent ~30 posts against THAT account's own median (likes +
   comments when view counts aren't available). Pick the top ~6 and two
   laggards for contrast.
2. Transcribe each top hook as a package: spoken line, on-screen text,
   first visual, caption first line — and label its catch mechanism and
   pattern.
3. Write `data/inspiration/<handle>-<date>.md`, and distill what earns a
   place into `data/swipe.md` — the growing swipe file: one entry per
   mechanism-in-action, with the source permalink and a TTK-voiced
   adaptation.

Hard rules for using what we find:
- **Steal the mechanism, never the words** — an adapted hook is rebuilt in
  TTK voice, not paraphrased from theirs.
- **Never their visuals** — patterns only; colours, fonts, and treatments
  stay TTK (standing brand rule).
- **Their fear/shame/hype hooks get re-engineered, not imported** — same
  tension, kinder direction, through the writing floor like everything else.
- Numbers from other accounts grade as Public (API or scraped, per the
  ladder); why-it-works claims stay Inferred.

## Trends mode — what to make next

Answers "which ingredients/topics are worth content." Follow
`references/performance-and-trends.md`; produce a ranked shortlist, not a
data dump.

1. **Own signal first** (most reliable): from the latest snapshot, which
   `topic`/`primary_ingredients` tags keep landing in the top quartile on
   saves + shares (or the best available proxy)? That is *your* audience
   speaking, and it outranks any external source.
2. **Peer signal**: what those topics look like on the study accounts.
3. **External demand (free, no token)**: Google Trends and Pinterest Trends
   for seasonality and rising queries; fetch via `/browse` or WebSearch.
   Layer the seasonality calendar (back-to-school, summer, fall).
4. **Decide**: an ingredient/topic earns a slot when rungs agree — own top
   quartile AND peer traction AND rising/seasonal demand. One rung is a
   hypothesis; three aligned is a plan. Pair each pick with a proven hook
   pattern from the account's own history.

Output: a short ranked list of topics/ingredients to shoot next, each with
which rungs backed it and its provenance grade. Say the n and the confounds
out loud (small-account caveat). Write it to `data/trends-YYYY-MM-DD.md`.

## Refresh is a drift report

Never silently rewrite the analysis. Re-pull public numbers, then report the
delta first: reels that moved quartiles, new posts since the last snapshot and
how their hooks fit the known patterns, patterns whose recent examples stopped
working. Then update the snapshot and hook bank — states and counts only, no
re-synthesis unless the drift is large enough that the user agrees the
patterns themselves need a fresh pass. The delta since the last snapshot is
often the most valuable output — surface it, don't bury it.

## Verification is bounded — one batched round, then stop

Before presenting any report or hook set, run ONE batch: the writing-floor
greps (food negativity, parent shaming, hype clichés), the said-on-camera
test on every hook, and a provenance check that no Inferred claim reads as
Measured. Fix everything in one pass, re-check once, ship. No open-ended
polishing loops.

## Branding — anything visual is TTK, nothing else

Hooks and captions are plain text, but two outputs are visual and must carry
The Toddler Kitchen brand, never a borrowed look:

- **Palette** (the established brand values — no ad-hoc hex, ever):
  teal `#72A6AF` (primary), pink `#E4ACAD` (secondary/CTA),
  pink light `rgba(228,172,173,.2)` and teal light `rgba(114,166,175,.3)`
  for backgrounds, body text `#32373C`, headings `#555`. The full usage table
  lives in `.claude/skills/front-end-design/SKILL.md`.
- **Fonts**: system sans for everything, Georgia italic for accent/display —
  never introduce a new font family without Brandon's approval.
- **Cover-text suggestions** (shoot mode) describe styling in these terms:
  brand teal or pink text blocks on the chosen frame, so reel covers read as
  one feed. When a winning reel from another account inspires a pattern, take
  the *pattern* only — never its colors, fonts, or visual treatment.
- **The Alison artifact**, if requested, is styled from this palette and these
  fonts, light and dark themes both derived from the brand values.

## Record and hand back

- Keep `data/` current: snapshots accumulate (never overwrite an old one),
  `hook-bank.md` and `pattern-report.md` are living documents that note their
  last-verified date in a header line.
- The shareable Artifact is the **creation kit** for the shoot (load
  `artifact-design` before building it): this skill owns its reel section
  (hooks, covers, captions), and `/kitchen-post` adds the companion blog
  post section to the SAME artifact — one page per creation that fleshes
  out Alison's idea end to end. Record the URL in the shoot's data file and
  always republish to it, never a sibling.
- **When performance data exists, put the evidence IN the artifact** (standing
  decision, Brandon 2026-09-02). Any real data we hold — an `analyze` run on
  our own account, or a `study`/inspiration read of peers — gets a compact
  **evidence panel** in the creation kit: the ranked patterns that back the
  hooks, each with its provenance grade and the number behind it (e.g.
  "finished-food-in-hand covers, up to 513K on peers · Public"), plus which
  hook draws on which pattern. The hook chips then reflect it: `Inferred`
  flips to `Public`/`Measured` where the pattern is backed. No data yet → the
  panel says so and the hooks stay `Inferred`. The evidence is *why* the hooks
  are shaped as they are — show it, don't bury it. Refresh the panel whenever
  a new analyze/study run lands.
- Hand back: what the evidence says in two or three sentences, the top
  recommended hook(s), and what would upgrade the analysis (usually: Insights
  exports for the top/bottom five reels).
