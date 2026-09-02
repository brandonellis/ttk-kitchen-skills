---
name: kitchen
description: Router for The Toddler Kitchen content suite. Use when the user types /kitchen, asks for the "full package" for a shoot, wants to be walked through creating content from photos ("guide me", "walk me through"), or points at a folder of photos to turn into content. Dispatches to kitchen-hooks (Instagram reels) and kitchen-post (blog posts), runs both as one pipeline, or guides the user through it checkpoint by checkpoint — one creation-kit artifact either way. The sub-skills remain directly invocable.
argument-hint: "[instagram <args> · post <args> · full <media-or-dish> · analyze · refresh · help]"
disable-model-invocation: false
---

# /kitchen — The Toddler Kitchen content suite

One creation, one kit: these skills are a package, not independents. The
shared spine is in `kitchen-hooks/references/` (`hook-writing-floor.md`,
`ttk-voice.md`) and every deliverable lands on the creation's single
artifact. This router just gets you to the right piece with less typing.

## Routes (first arg picks, the rest passes through)

| First arg | Goes to | Notes |
|---|---|---|
| `instagram` (or `ig`, `hooks`, `reel`) | `kitchen-hooks` | e.g. `/kitchen instagram shoot <path>` → `kitchen-hooks shoot <path>` |
| `post` (or `blog`) | `kitchen-post` | e.g. `/kitchen post <dish>` → `kitchen-post <dish>` |
| `full` (or `package`, `kit`, `full package`) | the pipeline below | The whole creation in one run, no checkpoints — decisions made autonomously and reported. |
| `guide` (or `guided`, `walkthrough`) | the pipeline, guided | Same pipeline with a checkpoint at each human-owned decision. The right default when Brandon or Alison wants to steer. See "Guide mode". |
| `update <creation> [hooks·post]` (or `revise`, `redo`) | update mode below | Rework ONE piece of a kit that already ran, same artifact URL. Not the WordPress update package — that stays `/kitchen post update <slug>`. |
| `analyze` · `refresh` | `kitchen-hooks` | Account-analysis modes pass straight through. |
| `study <@account …>` | `kitchen-hooks` | Inspiration study of accounts we like → swipe file. |
| `help` or *(nothing)* | this table | Print it with one-line examples and stop. Unknown first arg: print it and ask — never guess a route. |

Route by invoking the target skill via the Skill tool with the remaining
args verbatim. Both sub-skills also answer to their own names directly;
this router adds no rules of its own beyond the pipeline.

## The full-package pipeline (`/kitchen full <media-path-or-dish>`)

The order matters — hooks first, post second, one artifact throughout:

1. **`kitchen-hooks shoot <media>`** — read the footage, write the hook
   options, build the creation-kit artifact with the reel section, record
   the artifact URL in the shoot's data file.
2. **`kitchen-post <dish>`** — duplicate check (WordPress if up, gracefully
   without it), fresh post on the right angle, post section added to the
   SAME artifact, WP-ready markup saved to its data file.
3. **One handback**: the artifact URL, the lead hook, the post's angle and
   target query, and whatever needs Alison's confirmation — as one summary,
   not two.

Both steps load the shared writing floor and voice profile once; gates run
per deliverable. If step 1's media is missing or step 2's duplicate check
needs a decision only Brandon can make, stop at that step and say exactly
where the pipeline paused and why.

## Update mode (`/kitchen update <creation> [hooks|post]`)

For a creation that already has a kit. Rules:

1. **Find the creation**: match `<creation>` against the shoot files in
   `kitchen-hooks/data/` (and kitchen-post's drafts). Ambiguous → list the
   matches and ask; no match → say so and offer `full`.
2. **Load before touching**: the shoot data file, the draft file, and the
   recorded artifact URL. The artifact may have been updated by another
   session — the data files say what's current.
3. **Change only the asked piece.** New hooks leave the post section
   byte-identical; a post revision leaves the hook cards alone. Refinement
   preserves; only an explicit "redo the whole kit" replaces.
4. The changed piece goes through its own skill's floor, voice, and gates
   exactly as a fresh run would.
5. **Republish to the recorded URL — never mint a sibling** — and append a
   one-line dated changelog entry to the affected data file (what changed
   and why). Corrections that affect both pieces (a recipe fact, a claim)
   propagate to both, each noted.
6. Piece omitted? Infer it from what the user asked for; if genuinely
   unclear, ask once with the pieces as options.

## Guide mode (`/kitchen guide [media-or-dish]`)

The same pipeline, walked through together. Checkpoints (AskUserQuestion,
one at a time, each with a recommended default so "just pick for me" is
always an option):

1. **The shoot** — scout the given directory (or the Media locations below,
   newest first), show the candidate groups, confirm which one.
2. **The lead hook** — present the drafted options compactly, ask which
   should lead (recommend the evidence-backed pick).
3. **The post angle** — after the duplicate check, present the angle (or
   the 2–3 candidates when several are strong) with target queries.
4. **Ship it** — artifact built; ask if anything should change before it's
   called done (one revision round, then stop).

Everything between checkpoints runs exactly as `full` does. Skip a
checkpoint silently when it has only one sensible answer (one media group,
one viable angle) — a guide that asks rhetorical questions teaches the user
to stop reading them.

## Media locations (standing — update when Brandon names new ones)

1. `wp-content/uploads/YYYY/MM/` — the prod media-library mirror; newest
   month first.
2. *(none named yet)* — when Brandon points at a personal photo folder
   (Desktop, iCloud drop, etc.), record it here so future runs scout it
   without asking.

Scouting rules live in kitchen-hooks' shoot mode (grouping by stem +
capture-time proximity, HEIC conversion via sips).
