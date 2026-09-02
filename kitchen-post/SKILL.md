---
name: kitchen-post
description: Draft a fresh Toddler Kitchen blog post from a shoot (media + kitchen-hooks work), delivered on the creation-kit artifact — net-new content by default, pivoting to a complementary angle when a post on the recipe already exists. Use when the user wants a blog post from a shoot or recipe creation, a post draft, or to sync a reel with its blog post. The WordPress update package runs ONLY when explicitly asked. Voice comes from the measured site profile (ttk-voice.md) — never invented.
argument-hint: "[<shoot-file or dish> · update <post-id-or-slug> (explicit ask only) · help] — no args uses the latest kitchen-hooks shoot"
disable-model-invocation: false
---

# /kitchen-post — from shoot to Toddler Kitchen blog post

Part of the `/kitchen` suite (with `/kitchen-hooks`): one creation, one
artifact. Reachable as `/kitchen post …` or `/kitchen full …`.

Companion to `/kitchen-hooks`: where that skill writes the reel's opening,
this one writes (or updates) the blog post behind the link-in-bio. Same two
identities — Alison's RD credential and evidence over instinct — plus one
more that governs everything here:

**The site is the voice.** Any blog post on the local WordPress or on
www.thetoddlerkitchen.com defines The Toddler Kitchen's voice. Never draft
from a generic food-blog register. The measured voice profile lives in
`../kitchen-hooks/references/ttk-voice.md` (derived 2026-09-01 from all 143
published posts) — load it before drafting. When the profile and a live
post disagree, the live site wins; update the profile.

The writing floor is shared: load
`../kitchen-hooks/references/hook-writing-floor.md` before drafting and run
its grep gates on the finished draft. Everything it bans in a hook is banned
in a post.

## Modes (from args)

| Args | Mode | What it does |
|---|---|---|
| *(none)* or `<dish>` | fresh post (default) | Locate the shoot, run the duplicate check, then draft **net-new content**: no existing post → the recipe post itself; post exists → a complementary post on a distinct angle and keyword the site doesn't have (toppings guide, self-feeding angle, serving variations), linking to the existing post — never a near-duplicate that competes with it, and never a silent switch to update mode. |
| `update <id-or-slug>` | update package | **Only when Brandon explicitly asks for updates** (standing decision, 2026-09-01). Build the update package for that post: unused shoot images, reel cross-promo, corrections. Never the default. |
| `help` | show the modes | Print this table and stop. Unknown args: show the table and ask, never guess. |

## Phase 1 — ground the run (scan first, ask second)

1. **Shoot context**: the named shoot file, or the latest in
   `../kitchen-hooks/data/`. Note the media paths, the hook sheet, and any
   artifact URL recorded there.
2. **Duplicate check is mandatory.** `df -h /` first (a full disk wedges
   Docker exec — see project memory). Then query the local WP:
   `docker exec thetoddlerkitchen-wordpress-1 sh -c "php -d memory_limit=1024M
   /usr/local/bin/wp --allow-root --skip-plugins --skip-themes post list
   --post_type=post --s='<dish>' ..."` — the memory-limit and skip flags are
   required (Yoast fatals silently without them). Search `post` AND
   `wprm_recipe` types. If the stack is down, say so and confirm with the
   user before assuming no post exists.
3. **Voice study**: load `../kitchen-hooks/references/ttk-voice.md` — the
   measured voice profile derived from the full published corpus (spellings,
   dash style, vocabulary, openers, the post skeleton). The per-run study is
   then a DRIFT CHECK, not a fresh analysis: skim posts newer than the
   profile's date for changes, and pick a section exemplar from the same
   category. No WordPress? The profile plus the exemplar copies in
   `data/voice/` are sufficient — say that's what was used.
4. Ask ONE round only for what the scan cannot supply (typically: recipe
   quantities if no recipe card exists, target publish timing, anything
   Alison decided out-of-band). Skip if nothing is missing.

## Phase 2a — fresh post (the default)

If the duplicate check found an existing post, first pick the complementary
angle: what does this shoot show that the published post doesn't own as a
keyword? Name the angle and its target query in the draft header, and make
the existing post the first internal link.

Structure mirrors the site's published recipe posts (verify against the
voice study, don't assume): intro that earns the scroll (adapted from the
shoot's lead hook), affiliate disclosure placeholder, "Why You and Your
Child Will Love…" with the RD angle, ingredients + toddler-friendly topping
ideas with nutrition notes, instructions overview + a practical hint,
substitutions, variations with internal links, equipment, storage, a Toddler
Tip, FAQ (4–5 real questions), and the WPRM recipe card fields.

Hard rules:
- **Quantities are sourced, never invented.** From an existing recipe card,
  from Alison, or marked `[CONFIRM]` — a plausible-looking made-up tablespoon
  is worse than a visible gap.
- **Internal links follow the site IA**: Recipes are single dishes; Meal
  Ideas are roundups. Link 2–3 genuinely related posts found via wp-cli
  search, not guessed URLs.
- **Image plan from the actual shoot**: which upload goes in which section,
  each with descriptive food-positive alt text.
- **SEO fields**: title (keyword natural, parenthetical benefit like the
  site uses), slug, meta description ≤155 chars in site voice.

## Phase 2b — update package (explicit request only)

Never rewrite the post. Diff what the shoot + hooks work adds against what
the post already has, and deliver a short, specific package:
- Shoot images the post doesn't use yet, with placement and alt text.
- Reel cross-promo: where the reel embed belongs once posted, and the
  caption line that sends IG viewers to the post.
- Corrections flowing BACK to the hook work: the post's recipe card is the
  source of truth — if a hook or caption contradicts it, fix the hook sheet
  and republish its artifact (same URL), noting the change.
- Anything the post claims that the shoot now shows better (a new after
  shot, a cleaner step image).
Each item: what, where, why, ready-to-paste text. The user applies them; the
skill only touches WordPress itself when explicitly asked.

## The deliverable is the creation artifact, not WordPress

**Standing decision (Brandon, 2026-09-01):** each creation gets ONE shared
artifact — kitchen-hooks contributes the reel section, kitchen-post
contributes the blog post section — so the reel and the post flesh out
Alison's idea together on one reviewable page. The shoot's data file records
the artifact URL; always republish to that same URL, never a sibling.

- The post section renders readable on the artifact: title, slug/category
  chips, meta description, full body with the shoot's images, internal links
  as absolute www.thetoddlerkitchen.com URLs.
- The `data/draft-*.md` master keeps the WordPress-ready form (block markup,
  site-relative links) for whenever the post moves to WP.
- **Never create WordPress content — not even drafts — unless Brandon
  explicitly asks in that session.** A draft created helpfully is a draft he
  has to notice and clean up.

## WordPress is optional research, never a dependency

When the local stack is up, use it read-only: voice study, the duplicate
check, real slugs for internal links, recipe-card quantities. When it isn't
(no Docker, another machine), degrade gracefully: voice-study from published
post copies in `data/voice/` if present, or the live site via `/browse`;
say plainly which checks were skipped and what that lowers confidence on.
Local WP is a prod mirror; treat IDs/slugs as real.

## Verify, record, hand back

One batched round: writing-floor greps on the draft, a voice pass against
the studied posts (spellings, register), a provenance check that every
quantity and nutrition claim is sourced or marked `[CONFIRM]`. Fix once,
re-check once, stop.

Output lands in `data/` here (`draft-<slug>-<date>.md` or
`update-<slug>-<date>.md`, date from `date +%F`). Hand back: what was
produced and why (draft vs update package), the 2–3 highest-value items, and
what needs Alison's confirmation.
