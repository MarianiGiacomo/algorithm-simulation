FROM node:lts as build-stage

WORKDIR /app

COPY . .

RUN npm install -g gatsby-cli && \
    npm install && gatsby build

FROM alpine:3.8

WORKDIR /app

COPY --from=build-stage /app/public /app/public

# unsafe-perm is necessary to handle 'not get uid/gid' error in Heroku
RUN apk add --update --no-cache npm && \
    npm config set unsafe-perm true && \
    npm install -g serve && \
    adduser -D app

USER app

EXPOSE $PORT

CMD /usr/bin/serve -s -l $PORT public
 

