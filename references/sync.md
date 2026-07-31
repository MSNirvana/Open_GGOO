# 快照与增量同步

仅在用户要维护完整本地副本或下游数据源时使用。普通热榜和项目问答不要创建快照。

scope 必须是 `repositories`、`projects`、`project_events` 或 `explanations`。每个 scope 独立维护 cursor，不得混用。

## 首次快照

1. 请求 `GET /v1/sync/snapshot?scope=repositories&fields=minimal&limit=500`。
2. 保存第一页返回的 cursor，但在所有页面成功应用前不要启动 changes。
3. `page.has_more=true` 时，把 `page.next_page` 原样传回 `page` 参数。
4. 每页成功写入后再继续下一页；全部完成后原子记录 cursor。

## 增量

请求 `GET /v1/sync/changes?scope=repositories&cursor={cursor}&limit=100`。

- 按返回顺序应用 `upsert` 和 `remove`。
- `has_more=true` 时继续使用响应的新 cursor。
- 每页成功落库后才保存新 cursor；失败时从旧 cursor 重试。
- changes cursor 是长期流水账水位，不受快照翻页有效期约束。
- 收到 409 `snapshot_required` 时只重建对应 scope，不静默跳过变化。

`fields=minimal` 用于镜像和索引；只有确实需要完整公开字段时才使用 `full`。
