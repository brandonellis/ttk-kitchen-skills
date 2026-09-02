# Performance and trends — what to measure, and how to read it

Two questions this answers: *what makes a post do well* (metrics + attribution)
and *what to make next* (ingredient/topic trends). Both are graded by the same
provenance rules as everything else — a trend you can prove beats one you feel.

## The metric hierarchy (what actually predicts growth)

Not all numbers are equal. For a growing dietitian food account, rank them
this way and optimise for the top, not the bottom:

1. **Shares / sends** — the growth engine. A reel sent to a friend reaches
   past your followers; sends are what make a post go bigger than your usual.
   The single strongest "this traveled" signal.
2. **Saves** — intent to use later. For recipe content this is gold: a recipe
   people save is a recipe worth making variations of. Best **topic** signal.
3. **Follows from this post** — which one post converted a viewer into a
   follower. The clearest "this topic/hook earns audience" number.
4. **Watch-through / average watch time** — diagnoses the **hook**. Where
   viewers drop tells you if second one worked. High reach + low retention =
   the algorithm pushed it but the hook leaked.
5. **Comments** — community and an algorithm signal; questions mean engaged.
6. **Likes** — weakest. Vanity, easy to get, predicts little. It is often the
   *only* number visible when scraping, so we use it as a rough public proxy,
   labeled as such — never as the target.

**North star:** reach and new follows, driven by shares and saves, with
retention as the hook diagnostic. When someone asks "did it do well," answer
in that order, not in likes.

## Attribution — separate the hook from the topic from the timing

A post's result is hook x topic x format x timing x luck. To learn anything,
hold variables:

- To read **topic/ingredient** signal, compare posts with *comparable hooks*.
  "Smoothie bowls do well" is only true if the smoothie posts didn't just
  happen to have the best hooks.
- To read **hook** signal, compare posts on *similar topics*.
- Tag every post in the snapshot with `{topic, primary_ingredient(s), format
  (recipe-demo / listicle / talking-head / POV), hook_pattern, season}` so
  the analyze mode can slice by one field at a time.
- **Small-account caveat (load-bearing).** Under ~5 posts per pattern, it's an
  anecdote, not a trend. One flop does not kill a topic. At low volume,
  confounds (posting time, trending audio, a share from a big account)
  dominate the content itself. Report findings as directional hypotheses
  (Inferred) until the sample is real, and say the n out loud.

## Where trend signal comes from (ranked by reliability)

1. **Your own account over time** — the only signal from *your* audience, so
   the most reliable. Which ingredients/topics keep landing in your top
   quartile of saves and shares? That is your trend, not the internet's.
2. **Peer accounts** (`study` mode) — what is landing right now for the
   accounts Alison admires. Steal the mechanism, watch the topic.
3. **Instagram-native** — the professional dashboard's trends panel, trending
   audio, and what Explore/Search autocompletes for "toddler ___". Free,
   already in the app.
4. **External, free, and strong for food:**
   - **Google Trends** (trends.google.com) — ingredient and recipe
     seasonality and rising queries. Real search demand, great for timing
     ("smoothie" climbs in summer, "pumpkin"/"apple" in fall).
   - **Pinterest Trends** (trends.pinterest.com) — recipe discovery runs on
     Pinterest, and The Toddler Kitchen already uses it. Best early signal
     for *what parents will search a recipe for* 30-45 days out.
5. **Seasonality calendar** — the reliable evergreen cycle: back-to-school /
   lunchbox (Aug-Sep, why cookies + lunchbox content is timely now),
   no-bake + smoothies (summer), pumpkin + apple (fall), simple + healthy
   resolutions (Jan), holiday treats (Nov-Dec).

## Turning signal into a decision

An ingredient/topic is worth making when several rungs agree: it lands in your
own top quartile **and** peers are winning with it **and** Google/Pinterest
show rising or seasonal demand. One rung alone is a hypothesis; three aligned
is a plan. Always pair the topic with a proven hook pattern from the account's
own history — a hot ingredient with a flat hook still dies in second one.

## What needs the API vs what is free today

- **Free now (no token):** own public play/like/comment counts (scrape),
  peer study, Google Trends, Pinterest Trends, the seasonality calendar,
  the blog corpus (what topics the site already ranks for).
- **Needs the Graph API token** (see `instagram-data.md`): saves, shares,
  reach, follows-from-post, watch time — i.e. the top of the metric
  hierarchy. Until it is live, growth analysis runs on likes-as-proxy and
  says so; the recommendations are directionally right but not Measured.
