FROM alpine:latest

# bring in nginx
RUN apk --no-cache add nginx &&\
    mkdir -p /data/{nginx,web} &&\
    ln -sf /dev/stderr /var/lib/nginx/logs/error.log &&\
    ln -sf /dev/stdout /var/lib/nginx/logs/access.log &&\
    ln -s /var/log/nginx /var/lib/nginx/logs &&\
    ln -s /var/tmp/nginx /var/lib/nginx/tmp
    #ln -s /run/nginx /var/run/nginx &&\

# base configs
COPY nginx /app/nginx/

# multi-stage build could be valuable here; see Dockerfile-multistage
# COPY content /data/web/{name}

ARG BUILD_VERSION

# CCE-26895-3 - Ensure Software Patches Applied every build
RUN echo $BUILD_VERSION && apk upgrade --no-cache

EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGQUIT

# bring in your SSL keys some way (or see Dockerfile-reflex)
ENTRYPOINT /app/nginx/entrypoint.sh
