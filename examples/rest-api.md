# REST API 示例

## 当前 6 小时热榜

```bash
curl 'https://open.ggoo.ai/v1/rankings/repositories?window=6h&category=all&limit=10'
```

## Agent 分类的 24 小时热榜

```bash
curl 'https://open.ggoo.ai/v1/rankings/repositories?window=24h&category=agent&limit=10'
```

## 搜索项目

```bash
curl 'https://open.ggoo.ai/v1/projects?q=vllm&limit=10'
```

## 精确查询 GitLab 仓库

```bash
curl 'https://open.ggoo.ai/v1/repositories/example/project?host=gitlab'
```

## 获取项目详情

先从搜索或热榜响应取得真实项目 ID：

```bash
curl 'https://open.ggoo.ai/v1/projects/123/profile'
```
