FROM anasty17/mltb:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN pip3 install --upgrade pip
COPY /requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN apk add --no-cache libressl-dev musl-dev libffi-dev && \
    pip install --no-cache-dir cryptography>=2.8 && \
    apk del libressl-dev musl-dev libffi-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp

COPY . .

CMD ["bash", "start.sh"]
