FROM alpine:3.22
RUN apk add --no-cache tinyproxy
COPY tinyproxy.conf.template /etc/tinyproxy/tinyproxy.conf.template
COPY start.sh /start.sh
RUN chmod 755 /start.sh
EXPOSE 8888
ENTRYPOINT ["/start.sh"]
