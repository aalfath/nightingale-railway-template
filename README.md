# Nightingale on Railway

A Railway template for [Nightingale](https://github.com/ccfos/nightingale) (n9e), the open-source alerting and monitoring platform: alert rules over Prometheus, VictoriaMetrics, Elasticsearch, Loki, ClickHouse and SQL data sources, event processing, notification routing, dashboards, a built-in time-series database, an AI agent and an MCP server.

## What it deploys

| Service | Source | Notes |
|---|---|---|
| `nightingale` | this repo (`Dockerfile`) | Nightingale **v9.3.0**, `flashcatcloud/nightingale:9.3.0@sha256:b3799edd750b9885062fa3535159c12fac55bcf6b9a16aee4f75b08db8842d75`. Public domain on port 17000, health check `/ping`, volume at `/app/data` (built-in time-series database, alert evaluation records). |
| `MySQL` | Railway MySQL | Users, alert rules, dashboards, data sources, events. |
| `Redis` | Railway Redis | Login sessions, caches, agent heartbeats. |

On first start, `railway-start.py` runs Nightingale on `127.0.0.1` only, signs in with the upstream default `root` / `root.2020`, and changes that password to the generated `N9E_ADMIN_PASSWORD`. Only then does it start Nightingale on the public port. Sign in as **`root`** with the value of `N9E_ADMIN_PASSWORD` from the service's Variables tab.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `N9E_ADMIN_PASSWORD` | `${{secret(24)}}` | Password set for the `root` admin on first start. Change it later in the UI; the variable is only used while the default password is still active. |
| `N9E_AGENT_PASSWORD` | `${{secret(32)}}` | Basic-auth password agents (categraf, Prometheus remote write) use to push metrics and heartbeats. User: `agent`. |
| `N9E_SERVICE_PASSWORD` | `${{secret(32)}}` | Replaces the upstream default password on the internal service and job APIs (`/v1/n9e`, `/ibex/v1`). |
| `N9E_SITE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Base URL used in alert notification links (set on first start). |
| `MYSQL_URL` | `${{MySQL.MYSQL_URL}}` | Database connection (private network). |
| `REDIS_URL` | `${{Redis.REDIS_URL}}` | Redis connection (private network). |
| `PORT` | `17000` | HTTP port. |

Optional tuning (not in the template, add them to the service if needed): `N9E_TSDB_RETENTION` (default `15d`), `N9E_TSDB_MAX_BYTES` (default `3GiB`), `N9E_EVALLOG_MAX_GB` (default `1`), `N9E_LOG_LEVEL` (default `INFO`).

## Sending metrics

The built-in time-series database is registered as the `embedded-tsdb` data source. Install [categraf](https://github.com/flashcatcloud/categraf) on the machines you want to watch (the UI's agent page generates an install command) and give it the agent credentials `agent` / `N9E_AGENT_PASSWORD`. Or add your existing Prometheus or VictoriaMetrics as a data source and only use Nightingale for alerting.

## Updates

The template builds from this repo's `main` branch. When we bump the pinned Nightingale version, Railway shows deployers an "update available" notice; read [CHANGELOG.md](CHANGELOG.md) before applying it. Nightingale migrates its database schema on start.

## Local test

```sh
docker build -t n9e-railway .
# needs a MySQL 8 and a Redis; see the variables above
```

License: the wrapper is MIT; Nightingale is Apache-2.0.
