---
name: kitchen-email
description: Draft The Toddler Kitchen's weekly Sunday email in Kit (ConvertKit) - 1-3 seasonal recipes from thetoddlerkitchen.com with short blurbs, a starter intro for Ali to rewrite, a 3x5 Dinner Prep Method sale section near Black Friday, New Year or back to school, and a 3x5 P.S. on every email, in the TTK brand colours. Saves an unsent Kit draft, never sends. Use whenever Ali or Brandon asks for the weekly email, the newsletter, the Sunday email, a Kit broadcast, "this week's email", which recipes to feature in an email, or a Black Friday / sale email for the 3x5 method, even if Kit isn't named.
argument-hint: "[<send date YYYY-MM-DD> · sale \"<discount, code, end date>\" · recipes <url-or-slug,...> · help] - no args drafts for the coming Sunday"
disable-model-invocation: false
---

# /kitchen-email - the weekly Sunday email

Part of the `/kitchen` suite (with `/kitchen-hooks` and `/kitchen-post`).
It writes The Toddler Kitchen's weekly Sunday email: a few seasonal recipes
from the site, a starter intro, and a P.S. for the 3x5 Dinner Prep Method,
in the brand's colours. The result is an **unsent draft broadcast in Kit**.
Ali rewrites the intro, picks the audience and schedules it herself.

Two rules sit above everything else:

- **Never send, never schedule.** The skill creates a Kit draft and stops.
  An email that reaches thousands of inboxes can't be taken back, so the
  person who clicks Send is always Ali.
- **Nothing invented.** Every recipe is a real, live post. Every blurb fact
  comes from that post. Every sale detail comes from Ali. A visible
  `[CONFIRM]` is better than a plausible guess.

## Modes (from args)

| Args | What it does |
|---|---|
| *(none)* | Drafts for the coming Sunday. If today is Sunday, the send date is next Sunday unless Ali says "today". |
| `<YYYY-MM-DD>` | Drafts for that send date. Seasonality and sale windows follow this date. |
| `sale "<details>"` | Forces the sale box with Ali's details (discount, code, end date), even outside a window. |
| `recipes <url,...>` | Ali picked the recipes. Skip selection and write blurbs for these. |
| `help` | Print this table and stop. Unknown args: print it and ask. |

Args combine, e.g. `/kitchen-email 2026-11-29 sale "25% off with code BF25, ends Dec 1"`.

## Phase 1 - ground the run

1. **Send date and season.** `date +%F` for today, then work out the send
   Sunday. Load `references/email-template.md` (the email's shape and Ali's
   measured email voice) and `references/seasonal-calendar.md` (what fits
   this month, and whether the send date is in a sale window).
2. **3x5 facts.** Load `references/3x5-method.md`, then re-read the live
   sales page it links. If the price or contents changed, use the live page
   and flag it in the handback.
3. **Design.** Load `references/kit-layout.md`: the brand palette, the Kit
   template, and how the body is built from her latest sent email.
4. **Voice.** Load the shared writing floor
   (`../kitchen-hooks/references/hook-writing-floor.md`) and the blog voice
   profile (`../kitchen-hooks/references/ttk-voice.md`). The blog voice is
   the baseline. The email voice section of the template adjusts it for
   email.
5. **Kit history.** With the Kit connector:
   - `list_broadcasts` (about 15). Note every recipe linked in **completed**
     broadcasts from the last 8 weeks so you don't repeat them.
   - Read the newest completed one in full with `include: ["content_tree"]`.
     It's both the design source and a voice check. If its habits differ
     from the template file's email voice section, the newer email wins.
   - **Check for an unsent draft** created in the last ~3 weeks. If one
     exists, tell Ali and ask once whether to build on it or start fresh.
     She may already have this Sunday half-written.
   - **Kit not connected?** Say so in one line, carry on, and deliver the
     email as a preview file plus text in the chat. Skip the repeat check
     and say it was skipped.
6. **Sale check.** If the send date is in a sale window, or Ali passed
   `sale`, the email gets the sale box. In a window with no `sale` details,
   ask Ali once (one question with a "no discount, just feature it" option).
   If no one answers, write the box without discount claims.

## Phase 2 - pick the recipes (skip if `recipes` was given)

Get candidates from the live site, in this order:

1. **WordPress REST API** if `~/.config/ttk/` has the app password (same
   access as kitchen-post):
   `curl -u "$(cat ~/.config/ttk/wp-user):$(tr -d ' ' < ~/.config/ttk/wp-app-password)" "$(cat ~/.config/ttk/wp-url)/wp-json/wp/v2/posts?search=<ingredient>&_fields=id,slug,title,link,date,featured_media&per_page=20"`.
   Search 3-5 seasonal ingredients or holidays from the calendar.
2. **No credentials** (the usual case in Cowork): fetch the recipe hub
   (`https://thetoddlerkitchen.com/recipes-for-babies-and-toddlers/`) and
   the category pages it links, and run web searches restricted to
   thetoddlerkitchen.com for seasonal terms ("pumpkin", "apple",
   "Halloween"). The public wp-json endpoint blocks web fetching, so don't
   rely on it.

Choose 1-3 using the seasonal calendar's rules: in season, useful for
parents, a mix of meal types, not sent in the last 8 weeks. **Open every
chosen post** before writing about it. That confirms the link works and
gives you the blurb facts (time, freezer notes, age tips, iron) and the
featured image (`og:image`). A recipe you haven't opened doesn't go in the
email.

## Phase 3 - write the email

Follow `references/email-template.md`: 3 subject options, preview text,
greeting, the marked intro draft, the sale box (if any), the recipe blocks,
the sign-off, the P.S. box. Notes on the parts that take judgment:

- **The intro is a starting point.** Ali rewrites it, so keep it short and
  clearly marked, and never invent stories about her family.
- **Blurbs sell the usefulness, not just the food.** Answer "why would a
  tired parent click this on Sunday": it freezes, it's one pan, little
  hands can manage it, it covers lunchboxes all week. Each blurb uses at
  least one specific detail from the post.
- **The P.S. rotates.** It's a 3x5 call to action every week, so vary the
  angle (the 4pm scramble, one meal for everyone, short bursts instead of a
  prep marathon, the season). Check the last few emails' P.S. lines and
  don't repeat one.
- **3x5 claims stay inside the sales page.** Relief and time, yes.
  Promises that kids will eat, picky eating "fixed", "risk-free": never.
  The product file lists what's off-limits and why.

## Phase 4 - check, preview, then save the draft

Run this checklist once on the finished email. Fix what fails, re-check
once, then stop:

- **Writing-floor gates**: save the email text to a file and run the four
  grep gates from the writing floor (food negativity, parent shaming,
  clinical overreach, hype), pointed at that file instead of `hooks.md`.
  All return 0, or each hit has a written reason.
- **Voice**: Canadian spellings (flavour, favourite, colour), spaced hyphens
  and no em dashes (`grep -c '—'` returns 0), at most one emoji and only at
  the start of the subject or a heading.
- **Links**: every recipe URL was opened this run, and the P.S. links to the
  live 3x5 sales page.
- **Season**: each recipe has a one-line reason it fits this send date, and
  nothing is on the calendar's "hold back" list for this month.
- **Sale**: no discount, code or deadline unless Ali supplied it.
- **Brand**: every colour in the tree is from the palette in
  `kit-layout.md`, and the footer with the unsubscribe link is intact.
- **Length**: 200-350 words (up to 450 with a sale box).

Then:

1. **Preview.** Render the email as a simple HTML file in the brand colours
   and send it to the user, so it can be reviewed without opening Kit.
2. **Kit draft.** Build the `content_tree` as `kit-layout.md` describes
   (her latest sent email's header, card, bio and footer around this
   week's blocks), validate it against `get_broadcast_schema` for template
   3823624, and call `create_broadcast` with the subject, preview text,
   `email_template_id` 3823624, the tree and the latest email's `theme`.
   Leave `subscriber_filter` and `public` unset. `create_broadcast` only
   ever makes a draft, so don't call any other tool to "finish" it. If Kit
   rejects the tree, tell Ali and offer the HTML path rather than switching
   silently.

## Hand back

One short message:

- The Kit draft link (`confirm_url`), or "Kit wasn't connected, so the
  email is in the preview".
- The send date, the recipes chosen and one line on why each fits the week.
- The 3 subject options, with the one used marked.
- Anything to confirm: sale details, a 3x5 page change, an unsent draft
  that already existed, a skipped repeat check, a voice habit that changed.
- A reminder that the intro is hers to rewrite and that Kit only sends when
  she schedules it.
