# Changelog

Deployers: read the entry for the version you are moving to before you apply a Railway "update available" notice. Breaking changes come first.

## 9.3.0-railway.2 (2026-11-17)

- README: Deploy on Railway button for the published template `nightingale-1`. No change to the app or its configuration; you don't need to apply this update.

## 9.3.0-railway.1 (2026-11-17)

- First release of the template: Nightingale v9.3.0 (`flashcatcloud/nightingale:9.3.0@sha256:b3799edd750b9885062fa3535159c12fac55bcf6b9a16aee4f75b08db8842d75`).
- Railway MySQL for the database, Railway Redis for sessions and caches, a volume at `/app/data` for the built-in time-series database and alert evaluation records.
- The upstream default admin password (`root.2020`) is replaced with the generated `N9E_ADMIN_PASSWORD` before the public port opens. The upstream default agent and service passwords are replaced with generated ones. Anonymous queries are off.
