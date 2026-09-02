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

## Keeping this repo current

The canonical copies live in the project's `.claude/skills/`. To publish
changes here, run `./sync-from-project.sh` (it copies skill logic and excludes
every `data/` folder), then commit.

## Roadmap

See [CHANGELOG.md](CHANGELOG.md) for history and the repo's Issues for open
work (first account analysis, Graph API token, caption-voice profile).
