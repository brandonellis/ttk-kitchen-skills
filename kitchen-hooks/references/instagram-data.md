# Instagram data — the acquisition ladder and how each rung grades

Three ways to get Instagram data, in order of preference. Every number that
enters an analysis carries the grade of the rung it came from.

## Rung 1 — Instagram Graph API (official; own account = Measured)

One-time setup (Brandon, ~20 min):
1. @thetoddlerkitchen must be a **Professional** account (Business or
   Creator) linked to a Facebook Page Alison controls.
2. Create a Meta app at developers.facebook.com → add the Instagram Graph
   API product.
3. Generate a **long-lived user access token** with `instagram_basic`,
   `instagram_manage_insights`, `pages_show_list` (Graph API Explorer works
   for a personal-use token; no app review needed while the app stays in
   dev mode with Alison/Brandon as testers).
4. Store the token OUTSIDE the skills tree at `~/.config/ttk/ig-token`
   (one line). Never commit it, never write it into data/ or an artifact.
5. Long-lived exchange (short token from Graph API Explorer → 60-day token):
   `curl -s "https://graph.facebook.com/v26.0/oauth/access_token?grant_type=fb_exchange_token&client_id=APP_ID&client_secret=APP_SECRET&fb_exchange_token=SHORT_TOKEN"`
   → store `access_token` at `~/.config/ttk/ig-token` (chmod 600).
   **Expiry:** ~60 days. A 401/`OAuthException` from any skill call means
   the token lapsed — report "token expired, re-run the exchange", never a
   generic failure.
6. Resolve the IG user id once:
   `GET /me/accounts` → page id → `GET /{page-id}?fields=instagram_business_account`
   → store the id at `~/.config/ttk/ig-user-id` so skills don't re-resolve.

What the skills pull with it:
- **Own media list**: `GET /{ig-user-id}/media?fields=id,caption,media_type,media_product_type,timestamp,like_count,comments_count,permalink&limit=50`
- **Per-reel insights** (this is the Measured tier):
  `GET /{media-id}/insights?metric=views,reach,likes,comments,saved,shares,total_interactions,ig_reels_avg_watch_time`
  Average watch time is the closest thing to "where the hook lost them".
- Token check: `curl -s "https://graph.facebook.com/v26.0/me?access_token=$(cat ~/.config/ttk/ig-token)"`

## Rung 2 — Business Discovery (official; other accounts = Public/API)

The same token lets our account read OTHER Business/Creator accounts'
public media — the sanctioned way to study accounts we like:

```
GET /{ig-user-id}?fields=business_discovery.username(HANDLE){followers_count,media_count,media.limit(30){caption,like_count,comments_count,timestamp,permalink,media_type}}
```

Gives captions + like/comment counts + timestamps. No view counts, no
insights, and it only works if the target is also a Professional account
(most food/parenting creators are). Rank their content by likes+comments
relative to their own median — same account-as-its-own-baseline rule.

## Rung 3 — /browse scraping (fallback; Public/scraped)

Public reels grids show play counts for any account. Use the `/browse`
skill (never Chrome MCP), with `/setup-browser-cookies` if a login wall
appears. Restraint rules: ~30 reels per account per run, human pacing, one
retry max, read-only always (never like/follow/comment from automation).
Honest note: Meta's terms disfavour scraping — prefer the API rungs; treat
this as the interim while the token doesn't exist, and say in the report
which rung supplied the numbers.

## Provenance mapping (extends the grades in SKILL.md)

| Source | Grade in reports |
|---|---|
| Own insights via Graph API, or Insights screenshots | **Measured** |
| Business Discovery (other accounts, via API) | **Public (API)** |
| Scraped public grid/pages | **Public (scraped)** |
| Your judgment about why | **Inferred** (always labeled) |
