FROM node:lts-alpine3.15

# OPTIONAL : Can use ARGS to change path/folder name for project systematically
# ARG APP_NAME=app
# ARG APP_DIR=/home/node/${APP_NAME}
# And then replace app name 'app' with ${APP_NAME} and file paths such as  '/home/node/app' with ${APP_DIR} as needed. The 'app' folder in the directory can also be renamed to reflect the APP_NAME chosen.

# Current approach focuses on developing and deploying in the app folder
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
# COPY --chown=node:node app/package*.json ./ # Comment during init

USER node
# RUN npm install # Comment during init

# Copy all other files after pkgs have already been installed
# COPY --chown=node:node app ./ # Comment during init

EXPOSE 3000

CMD [ "npm", "start" ]
