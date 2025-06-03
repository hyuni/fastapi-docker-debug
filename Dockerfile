FROM python:3.9.4-alpine

COPY . /app/
WORKDIR /app/

# alpine 기반위에서 pip 모듈 빌드를 위해 필요한 패키지 설치 ===>
RUN apk update && \
    apk add --no-cache \
    gcc musl-dev linux-headers \
    build-base \
    curl \
    musl-dev \
    openssl-dev \
    && \
    rm -rf /var/cache/apk/*
    
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . "$HOME/.cargo/env"     

RUN pip install --upgrade pip

# <======================================================

RUN pip install -r requirements.txt

CMD uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
