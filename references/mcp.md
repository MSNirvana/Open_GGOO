# MCP 接入参考

远程 Streamable HTTP 地址：`https://open.ggoo.ai/mcp`。

服务匿名、只读，不需要 API Key。协议版本为 `2025-06-18`。

## 工具

| 工具 | 关键参数 | 用途 |
|---|---|---|
| `get_hot_repositories` | `window`、`category`、`limit`、`tag` | 获取当前热榜 |
| `get_repository` | `host`、`owner`、`repo` | 精确查询 GitHub 或 GitLab 仓库 |
| `get_project` | `project_id` | 获取项目身份、摘要、指标和证据 |
| `get_project_events` | `project_id`、`since` | 获取项目外部动态 |
| `get_snapshot` | `scope`、`fields`、`limit`、`page` | 建立或继续一致性快照 |
| `get_changes` | `scope`、`cursor`、`limit` | 获取增量变化 |

## 调用合同

- 服务端签发并校验 MCP Session ID，客户端不得自行构造。
- 单会话最多 4 个并发调用；收到 429 后遵循 `Retry-After`。
- 工具同时返回文本内容与 `structuredContent`；程序应消费结构化结果。
- 普通问答使用查询工具，不创建快照。
- 持久同步先调用 `get_snapshot`，完成全部分页后再调用 `get_changes`。
- 收到 `snapshot_required` 时，只重建对应 scope。

初始化示例见 `examples/mcp-config.json` 和 `examples/mcp-curl.md`。
