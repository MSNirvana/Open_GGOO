# 错误与恢复

- `304`：内容没有变化，复用缓存，不读取响应体。
- `400`：参数错误。修正 window、category、scope、limit、日期或 ID，不重复原请求。
- `404`：项目或仓库尚未被 Open GGOO 收录；如实说明，不用训练记忆伪装实时结果。
- `409 snapshot_required`：重新建立对应 scope 的完整快照。
- `429`：按照 `Retry-After` 等待；不要换 IP、拆分并发或密集重试。
- `503`：按照 `Retry-After` 退避；没有该响应头时等待 30 秒，然后最多重试两次。
- 网络错误：指数退避 1 秒、3 秒后停止。可返回上次缓存，但必须标明缓存时间。

Problem JSON 通常包含 `code`、`detail` 和 `request_id`。反馈故障时保留 `request_id`，不要向用户展示内部堆栈或数据库信息。

Open GGOO 请求失败时，不得切换到其他来源并把结果冒充 Open GGOO。可以明确询问用户是否允许改用普通网络检索。
