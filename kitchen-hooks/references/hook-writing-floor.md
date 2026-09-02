# Hook writing floor — the voice rules for The Toddler Kitchen

Every hook, caption, cover text, and analysis sentence is held to these rules.
The account belongs to Alison, a registered dietitian; the audience is tired
parents of toddlers. The floor exists so nothing published (or written about
her posts) undercuts either the credential or the parent reading it at 6am.

## Hard rules (grep-gated)

Run these on any file of hooks or analysis before presenting it. A hit is not
automatically fatal, but every survivor needs a written reason it is the only
right word.

1. **No food negativity.** Registered dietitians practice food neutrality:
   there are no bad foods, no toxic ingredients, no foods to fear. Gate:

   ```bash
   grep -ciE 'bad food|worst food|junk food|toxic|poison|avoid (this|these) food|never (feed|give)|hidden danger|harming your|ruining your|addicted to sugar|sugar is|processed garbage|clean eating|guilt[- ]free|cheat (day|meal)|empty calories' hooks.md
   ```

2. **No parent shaming.** Fear and failure hooks ("you're feeding your kid
   wrong") get clicks and cost trust. The reframe is always toward ease,
   relief, or curiosity — same energy, kinder direction. Gate:

   ```bash
   grep -ciE "you'?re (doing|feeding|making).*(wrong|mistake)|stop (doing|making|feeding)|biggest mistake|parenting fail|you should be|why you shouldn'?t|red flag" hooks.md
   ```

3. **No clinical overreach.** Nothing Alison couldn't defend to a peer RD: no
   cures, no guarantees, no diagnosis-adjacent claims. Gate:

   ```bash
   grep -ciE 'cure|cured|fix your picky|guarantee|proven to|boost immunity|superfood|detox|gut[- ]heal' hooks.md
   ```

4. **No hype clichés.** The same AI-slop list every account uses. Gate:

   ```bash
   grep -ciE "game[- ]?chang|life[- ]?chang|mind[- ]?blow|you won'?t believe|wait for it|secret weapon|hack your|unlock|elevate|transform your" hooks.md
   ```

## The safety exception

Choking hazards, allergen introduction, and food-safety prep are legitimate RD
content and are NOT food negativity — but they are framed as capability, not
fear. "How to serve grapes safely at every age" passes; "grapes are a hidden
danger in your kitchen" fails. The food is never the villain; the prep is the
content.

## The tests (judgment calls, run on every hook)

- **The said-on-camera test.** Would Alison say this sentence to a real parent
  in her kitchen, on camera, comfortably? If it needs a breathless influencer
  voice to work, rewrite it.
- **The first-frame test** (shoot mode). The spoken hook, the on-screen text,
  and the first visual must agree. A curiosity hook over a frame that already
  answers the question is a broken hook.
- **The swap test.** If the hook would survive unchanged on any food account
  after swapping the dish, it says nothing. Anchor it in something specific:
  the dish on camera, the toddler behavior, the RD's vantage point.
- **The 6am test.** The reader is a tired parent scrolling before the kids
  wake. The hook should land as relief, recognition, or genuine curiosity —
  never as one more thing they're failing at.

## The catchy floor — kind is not the same as flat

The bans above remove fear, shame, and hype. They do not remove tension —
and a hook with no tension is decoration, not a hook. Every hook must earn a
mid-scroll stop, and "warm and pleasant" alone never does.

**The mechanism rule (operational, checkable):** every hook names which
catch mechanism it uses. If none fits, the hook isn't done:

- **Curiosity gap** — the line opens a specific question only the video
  answers ("doing more work than the smoothie" — what work?).
- **Vivid specific** — a concrete image the reader can see instantly
  ("she was wearing half of it" beats "it got messy").
- **Twist** — the sentence turns on itself; set-up, then subversion
  ("…and that was the plan").
- **Claimed payoff** — the benefit stated plainly and worth having
  ("breakfast she feeds herself").

**The flatness check:** if the line could sit under any nice food photo
without raising a question or promising anything ("A lovely breakfast for
little ones!"), it fails — rewrite around one of the four mechanisms.

The energy of the banned hooks gets redirected, not deleted: "the biggest
smoothie mistake" becomes "the toppings are doing more work than the
smoothie" — same tension, kinder direction.

## Patterns that fit this account

Starting vocabulary; the pattern report grades these against real numbers and
may add, promote, or retire entries. Each with the shape and one example:

- **Relatable scene** — name the moment every toddler parent knows.
  "POV: they asked for it, you made it, and now it's 'yucky'."
- **Curiosity gap** — open a specific question the video answers.
  "The snack my toddler clients ask for by name."
- **Direct value** — the payoff stated plainly, numbers help.
  "Three lunches from one batch of these."
- **Credential-led** — the RD vantage point as the hook.
  "What a pediatric dietitian actually packs for daycare."
- **Gentle myth-reframe** — replace a worry with a fact, no scolding.
  "A toddler's appetite is supposed to look like this."
- **Permission slip** — relief as content.
  "Serving the same lunch three days straight is a strategy, not a rut."

## Sentence craft

- Hooks are spoken language: contractions, short words, one idea. Read each
  aloud once before keeping it.
- Front-load the concrete noun; put the strongest word at the end.
- On-screen text is ≤8 words and never duplicates the spoken line — it adds
  the second layer (the who, the payoff, or the twist).
- Caption first line does the hook's job for sound-off scrollers: it must
  stand alone before the fold.
- Plain words: make, serve, eat, love, refuse — not utilize, incorporate,
  consume, optimize.
