# Nightingale for Railway: the official image, pinned by version and digest,
# plus a small start script that writes config.toml from Railway variables and
# replaces the default admin password before the public port opens.
FROM flashcatcloud/nightingale:9.3.0@sha256:b3799edd750b9885062fa3535159c12fac55bcf6b9a16aee4f75b08db8842d75

COPY railway-start.py /app/railway-start.py

ENV TZ=UTC \
    PYTHONUNBUFFERED=1

WORKDIR /app
EXPOSE 17000

ENTRYPOINT ["python3", "/app/railway-start.py"]
