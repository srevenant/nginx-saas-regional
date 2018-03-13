#!/bin/sh

cd /app/nginx

sed -e 's/%ENVIRON%/'${ENVIRON}'/;s/%REGION%/'${REGION}'/g' nginx.conf.in > nginx.conf
exec nginx -c /app/nginx/nginx.conf
