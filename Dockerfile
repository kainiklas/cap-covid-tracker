FROM node:14-alpine

# we want to run in productive mode
ENV NODE_ENV production

# copy source
WORKDIR /usr/src/app
COPY . .

# install dependencies
RUN npm ci --only=production

# deploy sqlite db
RUN npm i "@sap/cds-dk"
RUN npm run deploy

## run cap
EXPOSE 4004
CMD ["npm", "start"]