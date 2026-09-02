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

Then link it to the blog post and embed the card. WPRM renders via the recipe
block; the classic shortcode `[wprm-recipe id="ID"]` also works in post content.
Set `wprm_parent_post_id` to the blog post id so the card claims its parent.

## Connecting to the API (prod: www.thetoddlerkitchen.com)

Two supported ways; pick by access:

1. **WP-CLI over SSH (preferred, most reliable).** BigScoots gives shell
   access. Copy `recipe-create.php` up and `wp eval-file` it, exactly as
   local. Same saver, same result, no REST surface to fight.
2. **WP REST API + Application Password (no shell).** In WordPress, the
   author account → Users → Profile → **Application Passwords** → add one
   (e.g. "kitchen-post"). Authenticate REST calls with HTTP Basic
   (`user:app-password`). WPRM Premium exposes recipe endpoints under
   `/wp-json/wp-recipe-maker/v1/`; the WP core CPT lives at
   `/wp-json/wp/v2/wprm_recipe`. Store the app password OUTSIDE the repo
   (e.g. `~/.config/ttk/wp-app-password`), like the IG token. It is scoped to
   that user and revocable from the same screen.

**Guardrail (unchanged):** the skill never writes to prod unasked. Local WP is
a mirror for building and previewing; a recipe created there still has to be
recreated on prod by an explicit action Brandon takes.

## What kitchen-post emits

Every recipe draft now carries a **structured recipe block** (the array above,
as JSON in the draft's data file) alongside the prose, plus the ready-to-run
`recipe-create.php`. Quantities follow the same sourcing rule as the prose:
from Alison or an existing card, or marked `[CONFIRM]` — never invented.
