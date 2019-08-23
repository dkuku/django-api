FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN apk add --update --no-cache postgresql-client
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home /app \
    app
USER app

WORKDIR /app
COPY ./app/ /app/


