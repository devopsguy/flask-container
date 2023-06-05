# Builder
FROM python:3.10-alpine AS builder
LABEL org.opencontainers.image.authors="octavian@hlm.dev"
WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --no-cache-dir --no-compile -r requirements.txt

# Runner
FROM python:3.10-alpine
LABEL org.opencontainers.image.authors="octavian@hlm.dev"
WORKDIR /usr/src/app
EXPOSE 3000
ENV PYTHONUNBUFFERED 1
COPY --from=builder /usr/local/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY src/ .
USER 1001
CMD [ "gunicorn", "-w", "4", "-b", "0.0.0.0:3000", "--access-logfile=-", "wsgi:app" ]