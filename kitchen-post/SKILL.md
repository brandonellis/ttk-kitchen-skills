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
2. **Duplicate check is mandatory.** Two paths depending on the machine:
   - **Local WordPress present** (Docker mirror): `df -h /` first (a full disk
     wedges Docker exec — see project memory), then
     `docker exec thetoddlerkitchen-wordpress-1 sh -c "php -d memory_limit=1024M
     /usr/local/bin/wp --allow-root --skip-plugins --skip-themes post list
     --post_type=post --s='<dish>' ..."` (memory-limit + skip flags required —
     Yoast fatals silently without them).
   - **No local WordPress** (the standard case on other machines): use the
     **live site REST API** with the app password in `~/.config/ttk/`:
     `curl -u "$(cat ~/.config/ttk/wp-user):$(tr -d ' ' < ~/.config/ttk/wp-app-password)"
     "$(cat ~/.config/ttk/wp-url)/wp-json/wp/v2/posts?search=<dish>&_fields=id,slug,title,link"`.
     Same check, live source. Search `posts` AND `wprm_recipe` types.
   Either way, if neither is reachable, say so and confirm with the user
   before assuming no post exists.
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

Structure follows the **Feast recipe-post template** exactly — not free-form
prose. Emit the full block skeleton in `references/post-template.md`: intro,
hero image, affiliate disclosure, the Feast jump-to-recipe block, the
`toddlerkitchen/dietitian-approved` "Why You'll Love" info-box pattern,
ingredients (with topping subgroups + "See recipe card for quantities."),
instructions as `wp:columns` step rows (image + text), substitutions
(`feast-feature` list), variations with internal links, equipment, storage,
the `toddlerkitchen/dietitian-tip` "Toddler Tip" pattern, FAQ as a
`wp:yoast/faq-block`, the WPRM recipe block, related, and the Feast recipe
index. Keep the custom patterns' `patternName`/`className` intact so they stay
linked to their styling. A post from generic paragraph/heading blocks is
off-template and must not ship.

Hard rules:
- **Full length, never a stub.** A real TTK post runs ~1,000–1,400 words
  (corpus average ~1,277). Every skeleton section carries real, specific
  prose — the info box has 4–5 benefit bullets, ingredients each get a
  descriptive line, instructions are written out, substitutions/variations/
  storage are genuine paragraphs, the FAQ has 4–5 real Q&As. A thin draft
  that only fills the headings is not shippable; write it out.
- **Quantities are sourced, never invented.** From an existing recipe card,
  from Alison, or marked `[CONFIRM]` — a plausible-looking made-up tablespoon
  is worse than a visible gap.
- **A recipe post ships a real recipe card, not just prose.** When the draft
  is an actual recipe (not a roundup or ingredient explainer), emit a
  **structured recipe block** matching WP Recipe Maker's shape (name, summary,
  type, servings, times, grouped ingredients with amount/unit/name/notes,
  grouped instructions, notes, course/keyword) plus the ready-to-run
  `recipe-create.php`, so the post becomes a proper WPRM card like the live
  ones. Full schema and the create/connect paths:
  `references/recipe-structure.md`.
- **Match the site's block structure so the post looks identical, not just
  valid.** Real TTK recipe posts embed the recipe as the `wp:wp-recipe-maker/
  recipe` Gutenberg block (not a shortcode) and use `wp:feast/
  advanced-jump-to-block`, `wp:feast/fsri-block`, and `wp:yoast/faq-block`.
  Emit those, or the post renders valid but off-template (no jump button, no
  FAQ schema). Details in `references/recipe-structure.md`.
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
- **ALWAYS DRAFT STATUS ON PROD — NEVER PUBLISH.** When a prod push IS
  explicitly requested, the blog post is created with `post_status=draft`,
  full stop. The skill never publishes a live post; Alison reviews the draft
  in WP admin and clicks Publish herself. This is a hard safety rule with no
  exceptions — "post it" means "create the draft," never "go live." Confirm
  the draft URL back to Brandon after creating it. (The local-mirror test used
  `publish` only because localhost is a private mirror for previewing; prod is
  always draft.)

## WordPress access: local mirror OR live REST API

The skill needs to read (and, on request, write) WordPress. Two ways in:

- **Local Docker mirror** (this machine): read-only via wp-cli for voice study,
  the duplicate check, internal-link slugs, recipe quantities.
- **Live site REST API** (any machine, esp. no-Docker): the **WordPress
  Application Password** in `~/.config/ttk/{wp-url,wp-user,wp-app-password}`
  does everything the mirror did — read existing posts/recipes, and (on
  explicit request) create recipes via `/wp-recipe-maker/v1/manage/recipe` and
  DRAFT posts. This is the primary path when there's no local WordPress. Full
  setup + endpoints in `references/recipe-structure.md`.

Neither reachable? Degrade gracefully: voice-study from the exemplar copies in
`data/voice/`, note which checks were skipped and what that lowers confidence
on. Never invent a slug or quantity to fill a gap.

## Verify, record, hand back

One batched round against this **pre-ship checklist** — a draft that fails any
item is not shippable:

- **Voice gates pass**: writing-floor greps (food negativity, shaming,
  clinical overreach, hype) all return 0.
- **Voice pass**: Canadian spellings, spaced-hyphen dash, no emoji, the
  "As a dietitian and mom" register (see `ttk-voice.md`).
- **Full length**: ≥1,000 words, every template section carrying real prose,
  not a heading-only stub.
- **Template complete** (recipe posts): all the blocks present — Feast
  jump, the `dietitian-approved` info box, ingredients, `wp:columns` steps,
  `feast-feature` substitutions, the `dietitian-tip` box, the Yoast FAQ, the
  WPRM recipe block, the Feast index.
- **Recipe card**: present, and every quantity sourced; `[CONFIRM]` count is
  0, or each remaining one is surfaced to the user by name.
- **Internal links**: 2–3, each a real slug found via search, never guessed.
- **No spacing artifacts**: no empty paragraphs, stray `&nbsp;`, or `<br>`.

Fix once, re-check once, stop.

Output lands in `data/` here (`draft-<slug>-<date>.md` or
`update-<slug>-<date>.md`, date from `date +%F`). Hand back: what was
produced and why (draft vs update package), the 2–3 highest-value items, and
what needs Alison's confirmation.
