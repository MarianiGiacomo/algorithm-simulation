FROM ubuntu:18.04

WORKDIR /usr/src/app

COPY . .

RUN apt update && apt install -y curl && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash && \
    apt install -y nodejs && \
    npm install -g gatsby-cli && \
    apt purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/list/* && \
    npm install && gatsby build

EXPOSE 9000

CMD ["gatsby", "serve", "-H", "0.0.0.0"]
 

