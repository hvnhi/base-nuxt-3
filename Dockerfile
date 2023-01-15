# Dockerfile
FROM node:18-alpine

ENV APP_ROOT /var/jenkins_home/workspace/develop
# create destination directory
RUN mkdir -p ${APP_ROOT}
WORKDIR ${APP_ROOT}

# update and install dependency
#RUN apk update && apk upgrade
#RUN apk add git

# copy the app, note .dockerignore
COPY . ${APP_ROOT}
RUN yarn install
RUN yarn run build

EXPOSE 3000

ENV NUXT_HOST=127.0.0.1
ENV NUXT_PORT=3000

CMD [ "yarn", "start" ]