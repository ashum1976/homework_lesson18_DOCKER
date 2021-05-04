FROM alpine:3.12
MAINTAINER Andrey Shumeyko aka Dancer76 <a_shu@inbox.ru>
RUN apk update
RUN apk add --no-cache curl && apk add nginx && mkdir -p /run/nginx
EXPOSE 80
ADD /docfile/index.html /usr/share/nginx/html/
ADD default.conf /etc/nginx/conf.d/
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
