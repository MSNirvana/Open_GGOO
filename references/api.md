# REST API 参考

基础地址：`https://open.ggoo.ai/v1`。公开读取接口匿名、只读，无需 API Key。

## 热榜

`GET /rankings/repositories`

参数：

| 参数 | 可选值 |
|---|---|
| `window` | `6h`、`24h`、`7d`、`30d` |
| `category` | `all`、`skills`、`application`、`agent`、`model`、`developer_tool`、`infrastructure`、`other` |
| `mode` | `formal`、`bootstrap` |
| `limit` | 1 至 100 |
| `offset` | 大于等于 0 |

关键字段包括：`rank`、`rank_change`、`star_delta`、`heat_score`、`hot_commentary`、`repository`、`universe.snapshot_cutoff_at`、`universe.bootstrap`、`ranking_algorithm_version` 和 `meta.data_status`。

不同时间窗的 `heat_score` 是基于各自窗口重新计算的，不是项目固定评分。不要跨窗口直接比较分值。

## 项目

- `GET /projects?q={关键词}&category={分类}&page=1&limit=20`：搜索确认属于 AI 的项目。
- `GET /repositories/{owner}/{repo}?host=github|gitlab`：按代码来源和仓库名精确查询。
- `GET /projects/{id}`：仓库事实与当前指标。
- `GET /projects/{id}/profile`：项目身份、中文摘要、资产和证据。
- `GET /projects/{id}/events`：外部项目动态与来源。
- `GET /projects/{id}/evidences`：可追溯证据。
- `GET /projects/{id}/history`：Star 等指标历史。
- `GET /projects/{id}/comments`：公开匿名评论。

不要猜项目 ID。先从热榜、搜索或精确仓库查询中取得实际 ID。

## 缓存

保存响应的 `ETag`；相同 URL 的下一次请求带 `If-None-Match`。收到 304 时复用旧响应，不读取响应体，也不重新总结。遵循 `Cache-Control` 和 `Retry-After`。

完整机器可读合同：[https://open.ggoo.ai/openapi.json](https://open.ggoo.ai/openapi.json)
