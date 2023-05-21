FROM python:alpine AS builder

EXPOSE 3000

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir --no-compile -r requirements.txt && rm requirements.txt

COPY app.py .

CMD [ "python", "./app.py" ]