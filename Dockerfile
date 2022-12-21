FROM node:lts-alpine

WORKDIR APP

COPY . .

RUN npm i

RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "preview"]
