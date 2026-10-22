# Kit layout and brand colours

Measured 2026-10-22 from Ali's Kit account: the brand palette
(`list_colors`), the templates (`list_email_templates`) and her sent
broadcasts from Jul 19 and Aug 30, 2026, plus the unsent Oct 4 draft. Every
weekly email uses this design so the emails read as one series and match
thetoddlerkitchen.com.

## Brand palette and where each colour goes

The site palette (teal, pink, dark text) and the Kit brand palette
(`#72A6AF`, `#8DBEC7`, `#E4ACAD`, `#EFC795`, `#666666`) are one family.
Never introduce a colour that isn't on this list.

| Role | Colour | Notes |
|---|---|---|
| Email background (document) | `#F5F4F5` | From her template. Keep it. |
| Card background | `#FFFFFF` | The main content section. |
| Body text | `#32373C` | Site body colour. |
| Headings (recipe titles, section heads) | `#555555` | Site heading colour. Better contrast than teal for 28px text. |
| Links | `#72A6AF` | Brand teal, bold link text so it reads on white. |
| Recipe buttons | `#8DBEC7` background, `#FFFFFF` bold text | Her established recipe button. |
| 3x5 buttons (PS and sale) | `#E4ACAD` background, `#32373C` bold text | Brand pink for the CTA. Dark text because white on pink is too faint to read. This replaces the off-brand `#efa1ae` used in older emails. |
| P.S. box | `#F9EEEF` | Brand pink at 20% on white. |
| Sale box | `#E3EDEF` | Brand teal at 20% on white. |
| Sale accent (optional) | `#EFC795` | Kit gold, only as a thin divider or highlight inside the sale box, never as text colour. |
| Divider | `#72A6AF`, 2px | Already in her footer area. |
| Fonts | `-apple-system, BlinkMacSystemFont, sans-serif` | Her template's font. Don't add fonts. |

## The template and how to build the body

- **Template:** "Monthly Newsletter" (`email_template_id` 3823624, a
  Starting point template). Every sent broadcast since spring uses it.
- **Start from her latest sent broadcast, not a blank template.**
  `list_broadcasts` with `status: completed`, then `get_broadcast` with
  `include: ["content_tree"]` on the newest one. Keep these parts as they
  are and pass its `theme` through unchanged:
  1. The header section with the banner image (`qWPd2YdFp1S3rTZoWXUij2`).
  2. The white card section and its `theme`. Set the card theme's
     `paragraph.color` to `#32373C`, `heading-three.color` to `#555555` and
     `link.color` to `#72A6AF`.
  3. The about-me row (avatar plus "Hi, I'm Ali!..." bio), the teal divider
     and the social icons at the end of the card.
  4. The footer section with `{{ address }}`, Unsubscribe and Preferences.
     A broadcast without the unsubscribe link can't be sent, so never drop
     it.
- **Replace only the middle of the card** (from the greeting down to the
  sign-off) with this week's blocks, in this order:

```
paragraph   "Hi {{ subscriber.first_name }}!"
paragraph   [INTRO DRAFT - Ali to rewrite]  (bold, so she can spot it in the editor)
paragraph x2-4   intro text
row         sale box (sale weeks only): one column, backgroundColor #E3EDEF, padding 24
              heading level 3, paragraphs, button (#E4ACAD / #32373C)
per recipe:
  heading   level 3, the recipe title
  image     src = post's featured image, width 250, align left, wrapText true,
            href = post URL, alt = descriptive, food-positive
  paragraph the 2-3 sentence blurb
  button    href = post URL, label = recipe name, backgroundColor #8DBEC7,
            color #FFFFFF, bold
paragraph   "Have a great week!"   (or the sign-off line from the latest email)
paragraph   "Ali"
row         P.S. box: one column, backgroundColor #F9EEEF, padding 24
              paragraph "P.S. ..." (with "P.S." bold)
              button "See the 3x5 Dinner Prep Method" (#E4ACAD / #32373C)
paragraph   affiliate disclaimer: only if the email has an affiliate link,
            copied word for word from her latest email
```

- Call `get_broadcast_schema` with `email_template_id: 3823624` before
  building, and validate the tree against it. Images need a string `alt`
  (her older emails have `alt: null`, which the schema rejects).
- Never set a color inline on a text run when the theme already sets it.
  Theme colours keep the email editable in Kit.

## If the latest broadcast can't be read

Use `get_email_template` (id 3823624, `include: ["content_tree"]`) and
apply the palette above to its theme. Say in the handback that the email was
built from the template, not her last email, so the header banner and bio
may need adding by hand.

## Preview

Before the Kit call, render a quick HTML preview of the same content in
these colours (a local file sent to the user is fine), so the draft can be
checked even when Kit isn't connected.
