FROM node:21-alpine3.19

RUN npm install -g pnpm

WORKDIR /usr/src/app

COPY package.json ./
COPY pnpm-lock.yaml ./

RUN pnpm install

# Fix bcrypt issue with node 21
RUN pnpm uninstall bcrypt
RUN pnpm add bcrypt@5.1.0
RUN npm rebuild bcrypt --update-binary

COPY . .

EXPOSE 3004