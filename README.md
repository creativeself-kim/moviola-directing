# MOVIOLA Directing

MOVIOLA turns a screenplay into a first cut you can watch. It breaks the script into
scenes and cuts, draws a storyboard image for every cut, and extends each image into a
short video clip — before anything is shot.

This repository publishes the **Assistant Director skill** for MOVIOLA. Install it and
Claude Code, Cursor, or Codex can direct your MOVIOLA productions from a terminal,
following the same directing conventions the web Assistant Director follows, with your
own model doing the thinking.

**A MOVIOLA account is required.** The skill teaches your assistant how MOVIOLA works,
but the work itself lives on the MOVIOLA server, and reaching it takes a personal token
issued from your account. Sign in at
[moviola.vibeproduction.ai](https://moviola.vibeproduction.ai).

MOVIOLA's product documentation is published in Korean and English at
[moviola.vibeproduction.ai/docs](https://moviola.vibeproduction.ai/docs), and a Korean
reader can finish setup entirely there. This install guide is English.

## Two seats, one assistant

The Assistant Director sits in two chairs. On the web it runs on MOVIOLA's models; in
your terminal it runs on whichever model you brought. It is the same assistant either
way — same directing conventions, same rule checks before anything is saved or
rendered, same order of work.

The tool list is not identical. Tools that think *for* you — writing a scenario,
inferring shots, critiquing a draft — stay on the web, because in a terminal your own
model already does that thinking. What the terminal gets is the hands: list productions
and drafts, read an outline, add and edit scenes, cuts and characters, run storyboard
and video generation. A terminal session usually opens by rebuilding the context the
web seat is handed for free — `list_projects` → `list_drafts` → `get_draft_outline` —
and then saves through the ordinary editing tools.

## Before you install

There are two one-time steps.

1. **Install the skill.** This teaches your assistant MOVIOLA's directing conventions
   and working order.
2. **Connect MCP.** MCP — the Model Context Protocol — is how your client calls
   MOVIOLA's tools. Connecting it with a personal token lets your assistant reach your
   own productions.

They are separate for one reason: a personal token cannot ship inside a public skill.
The skill is the same for everyone; the token is yours alone. Installing the skill
needs no token and no settings page, so it comes first.

## Install the skill

```bash
npx skills add creativeself-kim/moviola-directing \
  --skill moviola-directing moviola-setup \
  --agent claude-code cursor codex \
  --global \
  --yes
```

That installs two skills. **`moviola-directing`** is the directing manual, and your
assistant reaches for it when the work calls for it. **`moviola-setup`** you run by
name, once per work folder, to tie that folder to a production — it writes the
production card, pulls down the plans and notes already on the server, and points
`CLAUDE.md` at them.

The three agents are named rather than wildcarded on purpose. `--agent '*'` writes
skill directories for every agent the CLI knows about, installed or not. If your agent
is not one of the three, add it to the list.

**Plugin alternative.** Claude Code and Codex can take the same two skills as a plugin
instead, which puts installs and updates in one listing. Either path is enough on its
own, so there is no reason to install both. In Claude Code:

```
/plugin marketplace add creativeself-kim/moviola-directing
/plugin install moviola-directing@moviola
```

For Codex, in a shell:

```bash
codex plugin marketplace add creativeself-kim/moviola-directing --ref main
codex plugin add moviola-directing@moviola
```

## Get a token

In MOVIOLA, open the sidebar profile menu and go to **Settings → Terminal Tokens**.
Name the token after where it will be used — `claude-code`, say — and choose an expiry
of 30 days, 90 days, or never.

The token is shown **once**, at the moment it is created, so copy it then. It starts
with `mv_pat_`, acts as you across every production you can reach, and can be revoked
from the same table at any time.

## Connect MOVIOLA

Keep the token in an environment variable rather than writing it into a configuration
file, which may end up in git.

**Claude Code**

```bash
export MOVIOLA_PAT="mv_pat_YOUR_TOKEN"

claude mcp add \
  --transport http \
  --scope user \
  moviola https://storyboard-api.fly.dev/mcp \
  --header "Authorization: Bearer $MOVIOLA_PAT"
```

`--scope user` registers the connection for your account rather than the current
folder, so Claude Code finds MOVIOLA whichever directory you start it in.

**Codex**

```bash
export MOVIOLA_PAT="mv_pat_YOUR_TOKEN"

codex mcp add moviola \
  --url https://storyboard-api.fly.dev/mcp \
  --bearer-token-env-var MOVIOLA_PAT
```

**Any other MCP client** takes the same two values in its own way — an HTTP server at
`https://storyboard-api.fly.dev/mcp`, and an `Authorization: Bearer <token>` header.
Written out, the configuration is:

```json
{
  "mcpServers": {
    "moviola": {
      "type": "http",
      "url": "https://storyboard-api.fly.dev/mcp",
      "headers": {
        "Authorization": "Bearer ${MOVIOLA_PAT}"
      }
    }
  }
}
```

To check that it took, ask for something:

> Show me my MOVIOLA productions and drafts, and once I pick one, direct the next scene.

## Keeping it current

There is no separate update command. Run the install command again and it fetches the
current copy.

This repository is published by hand and can lag a MOVIOLA release, so nothing here
promises that the copy you install is the newest one. You do not have to watch for it:
the skill reports its version on every call, and when the server sees an old one, it
says so to your assistant while you work.

## When it does not connect

- **`401`** — the token has expired or been revoked. Issue a new one under
  Settings → Terminal Tokens.
- **It worked in the last terminal, not this one** — `MOVIOLA_PAT` is set per shell.
  A new terminal needs it again; put the `export` in your shell profile to stop
  repeating it.
- **Claude Code does not see MOVIOLA** — run `claude mcp list`, or `/mcp` inside a
  session, to see whether the server is registered and reachable.
- **Registered but not working** — remove it and add it again:
  `claude mcp remove moviola --scope user`, then the `claude mcp add` command above.
- **The tools work, but the conventions are ignored** — the MCP connection and the
  skill are separate installs. Every tool works without the skill; the method does not
  come with them.

## What it does and does not do

This is an assistant director, not a director. It does the work you would otherwise do
by hand — breaking a scene into cuts, filling in shot specs, keeping characters
consistent between images, queueing renders — and it does that work MOVIOLA's way
rather than inventing its own.

What it does not do is decide. It will not guess which production or draft you meant,
and it stops to ask before anything that costs money or cannot be taken back. Every
change it makes carries a reason, so the web seat shows what happened and why.

The rules behind that behaviour are written into the skill itself, and that text is
their only authoritative statement. After the install above you have it on your own
machine.

## What is in this repository

```
skills/
  moviola-directing/                the directing manual and its reference files
  moviola-setup/                    the work-folder setup skill
plugins/
  moviola-directing/                the same two skills, packaged as a plugin
.agents/plugins/marketplace.json    Codex marketplace listing
.claude-plugin/marketplace.json     Claude Code marketplace listing
```

Everything under `skills/` and `plugins/` is generated. The originals — the directing
conventions, the shared Assistant Director work manual, and the skill and plugin
metadata — live in MOVIOLA's own repository, AI4MOVIOLA, and a build reproduces them
here byte for byte. Editing a copy here does not change the skill; the next build
overwrites it.

Bug reports and wording problems are welcome as issues on this repository.
