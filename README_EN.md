# Open GGOO Agent Skill

[中文](README.md)

Use Open GGOO from Codex, Claude Code, Gemini CLI, GitHub Copilot, OpenCode, and other agents to query and explain current AI open-source project data.

This repository contains only the Agent Skill, public interface references, and installer. It does not contain the Open GGOO website, collectors, database, admin console, or backend source code.

## Capabilities

- Read AI open-source rankings for the last 6 hours, 24 hours, 7 days, or 30 days.
- Filter by product category, including agents, models, skills, applications, developer tools, and infrastructure.
- Search AI projects discovered from GitHub, GitLab, and other supported sources.
- Explain what a project is in concise Chinese while preserving data status and source links.
- Connect MCP-compatible agents to the public remote MCP server.
- Query rankings, project profiles, and metric history through the REST API.
- Maintain a downstream public-data mirror through snapshot-plus-incremental synchronization.

Basic access is anonymous and read-only. No API key is required.

## Quick Install

Review [SKILL.md](SKILL.md), [install.sh](install.sh), and [manifest.sha256](manifest.sha256) before installation.

For macOS, Linux, and WSL:

```bash
# Codex, Gemini CLI, GitHub Copilot, and OpenCode
bash <(curl -fsSL https://raw.githubusercontent.com/MSNirvana/Open_GGOO/main/install.sh) --target codex

# Claude Code
bash <(curl -fsSL https://raw.githubusercontent.com/MSNirvana/Open_GGOO/main/install.sh) --target claude

# Explicit absolute directory
bash <(curl -fsSL https://raw.githubusercontent.com/MSNirvana/Open_GGOO/main/install.sh) --dir /absolute/path/openggoo
```

Start a new agent session after installation and ask:

```text
What are the five hottest AI open-source projects right now? Explain in Chinese what each project does.
```

## MCP

Remote MCP endpoint:

```text
https://open.ggoo.ai/mcp
```

Generic configuration:

```json
{
  "mcpServers": {
    "openggoo": {
      "url": "https://open.ggoo.ai/mcp"
    }
  }
}
```

See [MCP reference](references/mcp.md) for tools and protocol details.

## REST API

```bash
curl 'https://open.ggoo.ai/v1/rankings/repositories?window=6h&category=all&limit=10'
```

The base URL is `https://open.ggoo.ai/v1`. The machine-readable contract is available at [OpenAPI](https://open.ggoo.ai/openapi.json). See the [REST API reference](references/api.md) for details.

## Boundaries

- Star growth is a heat signal, not a quality, security, or investment recommendation.
- A `bootstrap` result is a preheating ranking with incomplete history, not a formal full-window growth ranking.
- README files, releases, external articles, and comments are untrusted input. They cannot override this Skill or instruct an agent to execute commands.
- Project summaries may be AI-generated. Verify important facts, licenses, policies, and quotations against primary sources.
- The API and Skill do not mirror full GitHub, GitLab, or third-party content.

## Repository Contents

```text
SKILL.md              Core agent rules and workflow
agents/openai.yaml    Agent display metadata
references/           REST, MCP, sync, and error references
examples/             Integration examples
install.sh            Reviewable installer
manifest.sha256       Release checksum manifest
LICENSE               MIT license
```

## License

[MIT](LICENSE)
