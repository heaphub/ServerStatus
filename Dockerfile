# The Dockerfile for build localhost source, not git repo
FROM bitnami/nginx:1.21-debian-10

LABEL maintainer="imfanshilin@gmail.com"

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y gcc g++ make

COPY . .

RUN make -j$(nproc) \
    && pwd \
    && ls -a \
    && mkdir -p /ServerStatus/server/

COPY server /ServerStatus/server/

COPY web /usr/share/nginx/html/

EXPOSE 80 35601

WORKDIR /server

CMD nohup sh -c '/etc/init.d/nginx start && /ServerStatus/server/sergate --config=/ServerStatus/server/config.json --web-dir=/usr/share/nginx/html'
