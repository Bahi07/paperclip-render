# Paperclip + Hermes Agent — Render Deployment

Lightweight Docker image that combines:
- **Paperclip** (npm package) — AI agent orchestration platform
- **Hermes Agent** (pip) — AI agent CLI with 30+ tools

## Deployment on Render

1. Create a new Web Service on Render from this repo
2. Set environment to **Docker**
3. Dockerfile path: `./Dockerfile`
4. Add environment variables (see below)
5. Deploy

## Required Environment Variables

| Key | Value |
|-----|-------|
| `DATABASE_URL` | `postgresql://postgres:[PASSWORD]@aws-0-[region].pooler.supabase.com:5432/postgres` |
| `PORT` | `3100` |
| `SERVE_UI` | `true` |
| `BETTER_AUTH_SECRET` | (random string) |
| `PAPERCLIP_TOOL_ACTION_SIGNING_SECRET` | (random string) |

## Hermes Agent API Keys

Set at least one of:
- `ANTHROPIC_API_KEY`
- `OPENROUTER_API_KEY`
- `OPENAI_API_KEY`
- Or any Hermes-supported provider key
