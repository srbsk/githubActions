# Dockerfile
FROM python:3.7-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir flask

CMD ["python", "/app/app.py"]