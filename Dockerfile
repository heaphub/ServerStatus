FROM nginx:latest

LABEL maintainer="imfanshilin@gmail.com"

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y gcc g++ make

COPY server /ServerStatus/server/ \
    web /usr/share/nginx/html/

RUN make -j$(nproc)

EXPOSE 80 35601

WORKDIR /opt

CMD nohup sh -c '/etc/init.d/nginx start && /ServerStatus/server/sergate --config=/ServerStatus/server/config.json --web-dir=/usr/share/nginx/html'
