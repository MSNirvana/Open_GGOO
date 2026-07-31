# MCP 连接验证

初始化：

```bash
curl -i https://open.ggoo.ai/mcp \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"openggoo-check","version":"1.0"}}}'
```

保存响应中的 `Mcp-Session-Id`，随后请求工具列表：

```bash
curl https://open.ggoo.ai/mcp \
  -H 'Content-Type: application/json' \
  -H 'Mcp-Session-Id: <server-issued-session-id>' \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}'
```

Session ID 必须来自服务端响应，不得自行生成。
