FROM node:14-alpine

# use productive environment
ENV NODE_ENV production

# copy source as node user
WORKDIR /usr/src/app
COPY --chown=node:node . .

# install dependencies
RUN npm ci --only=production

# run app as node user
EXPOSE 4004
USER node
CMD ["npm", "start"]