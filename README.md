# TTK Kitchen Skills

A suite of [Claude Code](https://claude.com/claude-code) skills for turning a food
shoot into content for **The Toddler Kitchen** — Instagram reel hooks and a
matching blog post, produced together on one reviewable page, always in the
dietitian's own voice and never negative about food.

Built for one business, but the design ideas (a measured voice profile, a
grep-gated writing floor, provenance grades on every number) transfer to any
content-generation skill.

## The three skills

| Skill | Role |
|---|---|
| **`kitchen`** | Router. `full` runs the whole pipeline; `guide` walks it with checkpoints; `update` reworks one piece of a creation that already ran; `instagram` / `post` dispatch to the workers. |
| **`kitchen-hooks`** | Instagram reel hooks tailored to real footage, plus account analysis (`analyze`) and inspiration study of other accounts (`study`). |
| **`kitchen-post`** | A fresh blog post from the shoot, in the site's measured voice, delivered on the same artifact. Net-new by default; pivots to a complementary angle when a post on the recipe already exists. |

The workers stay independently invocable; the router just adds less typing and
the combined pipeline.

## Principles that make it safe to run unattended

- **One creation, one artifact.** Both skills publish to the same creation-kit
  page — the reel section and the post section flesh out a single idea end to
  end, and updates republish to the same URL.
- **Food-positive, RD-safe voice.** A shared, grep-gated writing floor bans food
  negativity, parent shaming, clinical overreach, and hype — the account belongs
  to a registered dietitian, so every line has to survive her saying it to a
  peer. See `kitchen-hooks/references/hook-writing-floor.md`.
- **Catchy is enforced, not hoped for.** Every hook names its catch mechanism
  (curiosity gap, vivid specific, twist, claimed payoff) or it isn't done.
- **The voice is measured, not invented.** `ttk-voice.md` is derived from the
  site's full published corpus (spellings, dash style, vocabulary, the post
  skeleton) rather than guessed.
- **Numbers are sourced, never invented.** Every metric and every "why it
  worked" claim carries a provenance grade: Measured (own insights), Public
  (scraped or Business Discovery), or Inferred (labeled judgment).
- **Brand, not borrowed.** Anything visual uses the established TTK palette and
  fonts; when another account inspires a pattern, only the mechanism is taken,
  never the look.

## Layout

```
kitchen/SKILL.md                        router
kitchen-hooks/SKILL.md                  reel hooks + account/inspiration analysis
kitchen-hooks/references/
  hook-writing-floor.md                 the food-positive + catchy voice rules
  ttk-voice.md                          measured site voice profile
  instagram-data.md                     Graph API / Business Discovery / scrape ladder
kitchen-post/SKILL.md                   blog post from the shoot
```

**`data/` is intentionally not in this repo.** Each skill writes its working
output (shoot notes, drafts, swipe files, voice exemplars) to a local `data/`
folder. That content is per-shoot and includes the client's published material,
so it stays out of version control (see `.gitignore`).

## Using these in a project

Copy the three skill folders into a project's `.claude/skills/`. The skills
reference each other by relative path, so keep them siblings. `kitchen-post`
and the analysis modes look for a local WordPress mirror when one is available
and degrade gracefully when it isn't.

## API access (setup on a new machine)

Credentials live **outside this repo** in `~/.config/ttk/` (never committed).
Clone the skills, then set up what you need:

**WordPress Application Password — required for the post/recipe pipeline.**
The only access that matters when there's no local WordPress. It runs the live
REST API: kitchen-post uses it to read existing posts (duplicate check,
quantities, internal links, voice study) and to create recipes + **draft**
posts on the live site. Create it in WP admin → Users → Profile → Application
Passwords, then store (chmod 600):
- `~/.config/ttk/wp-url` — e.g. `https://www.thetoddlerkitchen.com`
- `~/.config/ttk/wp-user` — the WordPress username it belongs to
- `~/.config/ttk/wp-app-password` — the 24-character password

Prod posts are always created as **drafts**; a human publishes.

**Instagram Graph API token — optional.** Only for *Measured* hook analysis
(reach / saves / shares / watch time). The suite works without it, via
user-provided Insights screenshots or a `/browse` read of the public grid.
Setup and endpoints in `kitchen-hooks/references/instagram-data.md`
(`~/.config/ttk/ig-token`, `ig-user-id`, `app-id`, `app-secret`).

**gstack `/browse` — optional.** Needed for competitor study, public-grid
reads, and Google/Pinterest Trends. A separate install; without it those modes
fall back to user-provided data.

**No key needed:** Google/Pinterest Trends (via `/browse` or web search) and
artifact publishing (built into Claude Code).

## Keeping this repo current

The canonical copies live in the project's `.claude/skills/`. To publish
changes here, run `./sync-from-project.sh` (it copies skill logic and excludes
every `data/` folder), then commit.

## Roadmap

See [CHANGELOG.md](CHANGELOG.md) for history and the repo's Issues for open
work (first account analysis, Graph API token, caption-voice profile).
