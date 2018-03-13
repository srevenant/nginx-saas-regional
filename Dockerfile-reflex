FROM alpine:latest

# bring in reflex and nginx
RUN apk --no-cache add python3-dev libffi ca-certificates \
    libffi-dev gcc libc-dev tar make nginx && \
    pip3 --no-cache-dir install rfxcmd && \
    rm -rf ~/.pip/cache $PWD/build/ && \
    mkdir -p /etc/nginx/server.d && \
    mkdir -p /etc/nginx/http.d

# base configs
COPY nginx /app/nginx

ARG BUILD_VERSION

# CCE-26895-3 - Ensure Software Patches Applied every build
RUN echo $BUILD_VERSION && apk upgrade --no-cache

EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGQUIT

WORKDIR /app/content

# with reflex
ENTRYPOINT ["launch", "service"]
# without -- bring in your SSL keys some other way (less secure?)
#ENTRYPOINT /app/nginx/entrypoint.sh
