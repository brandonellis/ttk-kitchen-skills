# Recipe structure — making drafts into real WP Recipe Maker cards

The "Feast recipe template" on the site is **WP Recipe Maker** (WPRM Premium
10.4.0); the Feast/Foodie Pro theme only styles it. A recipe is its own
`wprm_recipe` post, linked to the blog post and embedded as a card. This is
how a draft becomes a proper recipe card, structured exactly like the live ones.

## The data model (grounded in live recipe 7317)

A `wprm_recipe` post stores structured data in meta. The load-bearing fields:

- `wprm_type` = `food` (or `drink`)
- `wprm_servings`, `wprm_servings_unit`
- `wprm_prep_time`, `wprm_cook_time`, `wprm_total_time` (whole minutes)
- `wprm_ingredients` — array of **groups**, each `{name, ingredients:[...]}`;
  each ingredient `{amount, unit, name, notes}` (WPRM assigns uid/id/unit_id
  itself on save — do not fabricate them).
- `wprm_instructions` — array of **groups**, each `{name, instructions:[...]}`;
  each step `{text (HTML, wrapped in <p>), name, image}`.
- `wprm_notes` (HTML), `wprm_equipment`, and course/cuisine/keyword taxonomy.
- `wprm_parent_post_id` — the blog post the card belongs to.

Ingredient/unit names resolve to WPRM's internal taxonomy tables on save, so
they must be created through WPRM's saver, never by writing meta directly.

## Verified end-to-end (2026-09-02)

Proven on the local mirror: `WPRM_Recipe_Saver::create_recipe` + a post built
from the block set below rendered **pixel-identical to a native recipe post** —
Jump to Recipe + Print buttons, Feast Table of Contents, the full "modern" WPRM
card (times, servings, equipment, ingredients with notes, numbered steps), and
the sidebar/opt-ins. No design problems: the card's look is the global template,
independent of how it was created. (Benign `Undefined array key "id"` notices
appear during saver creation; ingredients/steps still render correctly.)

**No added spacing (verified).** The generated `post_content` had zero empty
paragraphs, zero `&nbsp;`, zero `<br>`, zero empty blocks — actually cleaner
than a hand-authored post (which carried 19 `<p class="">` and a stray `&nbsp;`
from the block editor). Block-to-block spacing comes from the theme/WPRM CSS on
the block *types*, which are identical, so the vertical rhythm matches. Blank
lines between blocks in the markup are stripped on parse and never render as
gaps. If a future generated post shows an unexpected gap, it's a real empty
block to remove, not an artifact of this method.

## The reliable create path — WPRM's own saver

`WPRM_Recipe_Saver::create_recipe($recipe)` (confirmed present) takes a clean
array and does all normalization. Feed it name, summary, type, servings,
times, grouped ingredients, grouped instructions, notes, course/cuisine/
keyword, nutrition. Run it with `wp eval-file` so the array lives in a file,
not on the command line:

```php
// recipe-create.php  (run: wp eval-file recipe-create.php)
$recipe = array(
  'name' => 'Berry Smoothie Bowl for Toddlers',
  'summary' => 'A thick, spoon-friendly breakfast...',
  'type' => 'food',
  'servings' => 2, 'servings_unit' => 'bowls',
  'prep_time' => 5, 'cook_time' => 0,
  'course' => array('Breakfast'), 'keyword' => array('toddler smoothie bowl'),
  'ingredients' => array(
    array('name' => '', 'ingredients' => array(   // '' = ungrouped
      array('amount' => '½', 'unit' => 'cup', 'name' => 'milk',   'notes' => ''),
      array('amount' => '¼', 'unit' => 'cup', 'name' => 'yogurt', 'notes' => ''),
      array('amount' => '1', 'unit' => 'cup', 'name' => 'frozen berries', 'notes' => ''),
    )),
  ),
  'instructions' => array(
    array('name' => '', 'instructions' => array(
      array('text' => '<p>Add milk and yogurt to a blender, then the frozen fruit.</p>'),
      array('text' => '<p>Blend until smooth, 30-60 seconds.</p>'),
    )),
  ),
  'notes' => '<p>Best enjoyed right after blending.</p>',
);
$id = WPRM_Recipe_Saver::create_recipe( $recipe );
echo "created wprm_recipe $id\n";
```

Then link it to the blog post and embed the card. Set `wprm_parent_post_id` to
the blog post id so the card claims its parent.

## The post must mirror the site's block structure (verified on post 7303)

The recipe *card* always looks right (global "modern" WPRM template). The
*post* only matches the site's other recipe posts if it uses the same blocks.
A real TTK recipe post is built from:

- `wp:wp-recipe-maker/recipe {"id":ID}` — the recipe embedded as a **Gutenberg
  block**, NOT the `[wprm-recipe]` shortcode. Use the block.
- `wp:feast/advanced-jump-to-block` — the "Jump to Recipe" button, near the top.
- `wp:feast/fsri-block` — Feast's recipe-index element.
- `wp:yoast/faq-block` — FAQs use the **Yoast FAQ block** (gives schema +
  the site's FAQ styling), not plain `wp:heading`/`wp:paragraph`.
- Standard `wp:paragraph`, `wp:heading`, `wp:list`, `wp:image` for the prose.

A post built from generic paragraph/heading blocks renders as valid Gutenberg
but is NOT identical to the template: it loses the jump button, the Feast
index element, and the FAQ schema. Generated recipe-post drafts must emit the
four blocks above to match. Non-recipe posts (ingredient explainers, roundups)
skip the recipe block but keep the Feast/Yoast blocks where the site uses them.

## Connecting to the API (prod: www.thetoddlerkitchen.com) — CONFIRMED WORKING

Auth is a WordPress **Application Password** over HTTPS Basic auth. Verified
2026-09-02. Credentials live outside the repo:

- `~/.config/ttk/wp-user` = `alisonjquinlan` (admin, Ali Ellis)
- `~/.config/ttk/wp-app-password` (24-char app password, chmod 600)
- `~/.config/ttk/wp-url` = `https://www.thetoddlerkitchen.com`

Use them: `PASS=$(tr -d ' ' < ~/.config/ttk/wp-app-password)` then
`curl -u "$(cat ~/.config/ttk/wp-user):$PASS" ...`. (Strip the display spaces
from the password.) The earlier 401 was a wrong username, not header stripping
— BigScoots passes the Authorization header fine.

**The canonical create path (remote, no SSH):**
`POST /wp-json/wp-recipe-maker/v1/manage/recipe` — the same endpoint WPRM's
editor posts to on Save, so it runs full normalization. Update an existing
recipe with `POST /wp-recipe-maker/v1/manage/recipe/{id}`. Helpers:
`/wp-recipe-maker/v1/modal/ingredient/parse` (turn "½ cup milk" into
amount/unit/name) and `/wp-recipe-maker/v1/nutrition/calculated` (auto
nutrition). Read recipes via the core CPT `/wp-json/wp/v2/wprm_recipe`.

Alternative (with shell): WP-CLI `wp eval-file recipe-create.php` calling
`WPRM_Recipe_Saver::create_recipe` — same result, useful for bulk/local.

**Security note (load-bearing).** This app password authenticates as an
**administrator** (user 1) with `manage_options` — it can change anything on
the site over REST, so treat it like a root key: it stays out of the repo and
out of any artifact, and every prod write is gated on an explicit Brandon
request. Consider a dedicated Editor-role account for this later (least
privilege); not required to work. Revoke anytime from Users → Profile →
Application Passwords.

**Dev-safe workflow (the guardrail, unchanged):** build and verify every
recipe on LOCAL first (POST to `http://localhost:8000/wp-json/...` or
`wp eval-file`), render the card, confirm it matches. Only replicate to prod
with the app password on an explicit instruction. The exact `/manage/recipe`
payload shape is confirmed against local before it is ever sent to prod.

**PROD POSTS ARE ALWAYS DRAFT.** The blog post that embeds the recipe is
created on prod with `post_status=draft` — never `publish`. Nothing goes live
automatically; Alison reviews the draft in WP admin and hits Publish herself.
When creating via `wp_insert_post`/REST, set the status to `draft` explicitly
(the recipe CPT can stay as WPRM sets it — the card is only visible through
the draft post, which is not public until Alison publishes it). Hand the draft
preview URL back to Brandon. No exceptions: "post it" = "create the draft."

## What kitchen-post emits

Every recipe draft carries a **structured recipe block** (the array above, as
JSON in the draft's data file, e.g. `data/recipe-<slug>.json`) alongside the
prose. Quantities follow the same sourcing rule as the prose: from Alison, an
existing card, or the live card read via the API, or marked `[CONFIRM]` — never
invented.

**Artifact-first (standing pattern).** The recipe renders into the creation-kit
artifact as a **WPRM-styled recipe card** (header with prep/cook/total/servings/
course, equipment, the ingredient table with amount/unit/name/notes, numbered
steps), in TTK branding, so the whole team reviews the exact structure before
anything is pushed. The card layout in the artifact mirrors WP Recipe Maker so
what you approve is what the site will render. Only after review, and only on an
explicit request, does the same structured object go to prod via
`POST /wp-recipe-maker/v1/manage/recipe`.

**The artifact shows the REAL post, in full (WYSIWYG, one source of truth).**
The blog content rendered in the artifact is the complete publishable post —
the same words, full length (~1,000–1,400 words), every template section, with
the recipe card embedded in its proper place (after the FAQ, before Related).
It is the review surface for the actual post, never an excerpt, summary, or
marketing-trimmed variant. The draft data file's block markup and the
artifact's rendered prose are the same content; if they diverge, fix it. What
Alison approves in the artifact is exactly what publishes.
