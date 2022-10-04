FROM node:9-alpine

RUN npm install yarn

WORKDIR /usr/app

COPY ./yarn.lock /usr/app
COPY ./package.json /usr/app

RUN yarn install

COPY . /usr/app/

RUN yarn build

FROM node:9-alpine
WORKDIR /usr/app

COPY --from=0 /usr/app/build /usr/app/build
COPY --from=0 /usr/app/package.json /usr/app/package.json
COPY .env /usr/app/.env
COPY docker-entrypoint.sh /usr/app/docker-entrypoint.sh
RUN chmod +x /usr/app/docker-entrypoint.sh

RUN yarn global add serve

RUN npm prune --production
ARG GCP_PROJECT_ID=xxxxx # SAMPLE ENVIRONMENT VARIABLES
ENV GCP_PROJECT_ID=$GCP_PROJECT_ID

ENTRYPOINT [ "/usr/app/docker-entrypoint.sh" ]
CMD [ "serve", "build" ]