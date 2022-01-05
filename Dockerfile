FROM nginx:latest

LABEL maintainer="imfanshilin@gmail.com"

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y gcc g++ make

ADD . . \
    server /ServerStatus/server/ \
    web /usr/share/nginx/html/

RUN make -j$(nproc) \
    && pwd \
    && ls -a

EXPOSE 80 35601

WORKDIR /ServerStatus

CMD nohup sh -c '/etc/init.d/nginx start && /ServerStatus/server/sergate --config=/ServerStatus/server/config.json --web-dir=/usr/share/nginx/html'
