#!/bin/sh

cd /app/nginx
sed -e 's/%ENVIRON%/'${ENVIRON}'/;s/%REGION%/'${REGION}'/g' nginx.conf.in > /run/nginx/nginx.conf

# running read-only, recreate the folders:
if [ ! -f /run/.created ]; then
    mkdir -p /run/lock
    mkdir -p /run/mount
    mkdir -p /run/nginx

    touch /run/utmp /run/.created
fi

ls -l /run 
echo 
ls -l /run/nginx

# cat /var/run/secure/pubkey > /run/nginx/example.com.crt
# cat /var/run/secure/prvkey > /run/nginx/example.com.key
# cat /var/run/secure/dhparams > /run/nginx/dhparam.pem

# introduce our cert data to /run/nginx
exec nginx -c /run/nginx/nginx.conf
