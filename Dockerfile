# Stage 1: build
# Parent image
FROM node:12.16-alpine AS builder

WORKDIR /app
# copy package.json
COPY package.json .

# get dependencies
RUN npm install

# copy source files
COPY . .

# build
RUN npm run build

# Stage 2: deploy
FROM node:12.16-alpine

# Set workdir
WORKDIR /app

# install typeorm (for database migration)
RUN npm install --save @nestjs/typeorm typeorm pg

# copy dist files
COPY --from=builder /app/dist ./dist

# copy node_modules
COPY --from=builder /app/node_modules ./node_modules
# copy package.json, .env
COPY --from=builder /app/package.json /app/.env ./

WORKDIR /
# copy entrypoint
COPY entrypoint.sh .

EXPOSE 3000

CMD ["./entrypoint.sh"]

