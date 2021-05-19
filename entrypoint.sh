#!bin/sh
# TYPEORM env variables
#export TYPEORM_ENTITIES=dist/entities/*.entity.js TYPEORM_MIGRATIONS=dist/migration/*.js TYPEORM_SUBSCRIBERS=dist/subscriber/*.subscriber.js

# database migration
cd app
typeorm migration:run

# start the app
node dist/main.js
