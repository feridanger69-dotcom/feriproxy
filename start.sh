#!/bin/sh
set -eu

: "${PROXY_USER:?Set PROXY_USER in Railway Variables}"
: "${PROXY_PASSWORD:?Set PROXY_PASSWORD in Railway Variables}"

# Keep config interpolation safe: only allow alphanumeric, underscore, and hyphen.
case "$PROXY_USER" in
  *[!A-Za-z0-9_-]*|'') echo "PROXY_USER may contain only letters, numbers, _ and -" >&2; exit 1 ;;
esac
case "$PROXY_PASSWORD" in
  *[!A-Za-z0-9_-]*|'') echo "PROXY_PASSWORD may contain only letters, numbers, _ and -" >&2; exit 1 ;;
esac

umask 077
sed \
  -e "s/__PROXY_USER__/$PROXY_USER/g" \
  -e "s/__PROXY_PASSWORD__/$PROXY_PASSWORD/g" \
  /etc/tinyproxy/tinyproxy.conf.template > /tmp/tinyproxy.conf

exec tinyproxy -d -c /tmp/tinyproxy.conf
