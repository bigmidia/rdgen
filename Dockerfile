# python:3.13.18-alpine publicado em 2026-11-12 (Docker Hub), fixado por digest
FROM python:3.13-alpine@sha256:9ef1a599f863231c3d91e941389bfdc4a2d6070557243d54df1a4e57015b960e

RUN adduser -D user
USER user

WORKDIR /opt/rdgen

COPY . .
RUN pip install --no-cache-dir -r requirements.txt \
 && python manage.py migrate

ENV PYTHONUNBUFFERED=1

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget --spider 0.0.0.0:8000

CMD ["/home/user/.local/bin/gunicorn", "-c", "gunicorn.conf.py", "rdgen.wsgi:application"]
