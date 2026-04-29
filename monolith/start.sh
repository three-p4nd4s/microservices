#!/bin/bash

mkdir -p /data/db
mongod --fork --logpath /var/log/mongod.log --dbpath /data/db
sleep 3
source /reddit/db_config
cd /reddit && puma || exit
