#!/bin/bash

DELAY=25

mongosh < /scripts/rs-init.js

echo "======= Sleeping for ${DELAY} seconds.... ======="
sleep $DELAY

mongosh < /scripts/init.js