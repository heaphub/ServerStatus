FROM nginx:latest

LABEL maintainer="imfanshilin@gmail.com"

COPY . /opt

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y gcc g++ make \
    && cd /opt/server \
    && make -j$(nproc) \
    && mkdir -p /ServerStatus/server/ \
    && mv /opt/server/* /ServerStatus/server/ \
    && mv /opt/web/* /usr/share/nginx/html/ \
    && rm -rf /opt/*

EXPOSE 80 35601

WORKDIR /opt

CMD nohup sh -c '/etc/init.d/nginx start && /ServerStatus/server/sergate --config=/ServerStatus/server/config.json --web-dir=/usr/share/nginx/html'
