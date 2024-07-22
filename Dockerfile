FROM node:20-alpine3.19
LABEL authors="Admin"

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build
CMD NODE_ENV=production node ./dist/index.js
