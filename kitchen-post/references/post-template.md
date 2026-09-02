# The Feast recipe-post template (block structure)

A TTK recipe post is not free-form prose. It follows a fixed skeleton built
from Feast blocks, two custom **Toddler Kitchen block patterns**, and standard
Gutenberg blocks. A generated recipe post must emit this structure in this
order, or it renders valid but off-template. Verified against live post 7303.

## The skeleton (in order)

1. **Intro paragraph** — the hook (adapted from the reel's lead hook).
2. **Hero image** (`wp:image`, sizeSlug full).
3. **Affiliate disclosure** paragraph (standard boilerplate).
4. **Jump to Recipe** — `<!-- wp:feast/advanced-jump-to-block /-->`
5. **"Why You'll Love" info box** — the `toddlerkitchen/dietitian-approved`
   pattern (markup below).
6. **Ingredients** — `wp:heading` "Ingredients for…", intro paragraph, an
   image, a `wp:list` of ingredients; optional `wp:heading level 3` subgroups
   (e.g. "Topping ideas") each with image + list; nutrition-note paragraphs;
   ends with the paragraph **"See recipe card for quantities."**
7. **Instructions** — `wp:heading`, an overview paragraph, then **one
   `wp:columns` per step** (image column + paragraph column, markup below);
   ends with an **"Enjoy!"** paragraph and a **"Hint:"** paragraph.
8. **Substitutions** — heading + paragraph + `wp:list` with
   `className:"feast-feature"`.
9. **Variations** — heading + paragraph (internal links to related recipes).
10. **Equipment** — heading + `wp:list`.
11. **Storage** — heading + paragraph.
12. **Toddler Tip** — the `toddlerkitchen/dietitian-tip` pattern (markup below).
13. **FAQ** — `wp:heading` "FAQ" + `wp:yoast/faq-block` (4-5 Q&As).
14. **Pin image** (`wp:image`, the tall pinnable graphic) — optional.
15. **Recipe card** — `<!-- wp:wp-recipe-maker/recipe {"id":RID} -->` /
    `<!-- /wp:wp-recipe-maker/recipe -->` (recipe created first, see
    `recipe-structure.md`).
16. **Related** — heading + "Looking for other recipes like this? Try these:".
17. **Recipe index** — `<!-- wp:feast/fsri-block {"categories_override":["…"]} /-->`

Non-recipe posts (ingredient explainers, roundups) drop 6/7/15 and the
recipe-specific bits but keep the info/tip patterns and Feast blocks where the
topic warrants.

## The two custom patterns (insert by name in the editor; reproduce this markup programmatically)

### `toddlerkitchen/dietitian-approved` — "Why You'll Love" info box

```html
<!-- wp:group {"metadata":{"categories":["toddler-kitchen","text"],"patternName":"toddlerkitchen/dietitian-approved","name":"Dietitian Approved Info Box"},"className":"tk-info-box","layout":{"type":"constrained"}} -->
<div class="tk-info-box wp-block-group"><!-- wp:heading {"className":"tk-info-box__title"} -->
<h2 class="tk-info-box__title wp-block-heading">Why You'll Love These …</h2>
<!-- /wp:heading -->
<!-- wp:paragraph --><p>As a dietitian and mom, …</p><!-- /wp:paragraph -->
<!-- wp:list {"className":"tk-info-box__list"} -->
<ul class="tk-info-box__list wp-block-list"><!-- wp:list-item -->
<li><strong>Lead-in:</strong> the benefit.</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list --></div>
<!-- /wp:group -->
```

### `toddlerkitchen/dietitian-tip` — "Toddler Tip" box

```html
<!-- wp:group {"metadata":{"categories":["toddler-kitchen","text"],"patternName":"toddlerkitchen/dietitian-tip","name":"Dietitian Tip"},"className":"tk-tip-box","layout":{"type":"constrained"}} -->
<div class="tk-tip-box wp-block-group"><!-- wp:heading {"level":3,"className":"tk-tip-box__title"} -->
<h3 class="tk-tip-box__title wp-block-heading">Toddler Tip</h3>
<!-- /wp:heading -->
<!-- wp:separator {"className":"tk-tip-box__divider"} -->
<hr class="tk-tip-box__divider wp-block-separator has-alpha-channel-opacity"/>
<!-- /wp:separator -->
<!-- wp:paragraph {"className":"tk-tip-box__body"} -->
<p class="tk-tip-box__body">The tip, in Alison's voice.</p>
<!-- /wp:paragraph --></div>
<!-- /wp:group -->
```

## Step columns (one per instruction, image + text side by side)

```html
<!-- wp:columns -->
<div class="wp-block-columns"><!-- wp:column -->
<div class="wp-block-column"><!-- wp:image {"id":IMG_ID,"sizeSlug":"full","linkDestination":"none"} -->
<figure class="wp-block-image size-full"><img src="…" alt="…" class="wp-image-IMG_ID"/></figure>
<!-- /wp:image -->
<!-- wp:paragraph --><p>Step text.</p><!-- /wp:paragraph --></div>
<!-- /wp:column -->
<!-- wp:column --><div class="wp-block-column"><!-- … next step … --></div><!-- /wp:column -->
</div>
<!-- /wp:columns -->
```
(Two steps per `wp:columns` row is the site's pattern; images come from the
shoot's step frames.)

## Notes

- The two patterns are registered on the site, so in the editor Alison inserts
  them by name; programmatically we emit the markup above. Keep the
  `patternName`/`className` intact so they stay linked to the pattern and its
  styling.
- `feast-feature` on the Substitutions list is what gives it the boxed style.
- Images referenced by `id` must exist in the media library (upload via the
  media API/`save_image` first, then reference the returned attachment id).
- Build and preview on local before any prod push (see `recipe-structure.md`).
