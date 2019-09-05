FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home /app \
    app
RUN chown -R app:app /vol
RUN chmod 755 /vol/web
USER app

WORKDIR /app
COPY ./app/ /app/


