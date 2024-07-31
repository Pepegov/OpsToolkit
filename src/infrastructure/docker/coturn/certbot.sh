#!/bin/bash

sudo certbot certonly --standalone --preferred-challenges http \
    --deploy-hook "docker restart coturn" \
    -d <YOUR_DOMAIN>