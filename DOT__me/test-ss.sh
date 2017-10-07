#!/bin/bash

set -ue

URL="https://ipinfo.io"

log () {
  echo $(date) "$@"
}

info () {
  log 'INFO' "$@"
}

error () {
  log 'ERROR' "$@"
}

LOCAL_PORT=11080

test-server () {
  local ENC_METHOD="$1"
  local PASSWORD="$2"
  local SERVER_PORT="$3"
  local SERVER_ADDR="$4"

  info "starting ss-local for server $SERVER_ADDR"

  local LOGFILE="/tmp/test-ss.$$.log"

  ss-local \
    -s "$SERVER_ADDR" \
    -p "$SERVER_PORT" \
    -m "$ENC_METHOD"  \
    -i "127.0.0.1"    \
    -k "$PASSWORD"    \
    -l $LOCAL_PORT    \
    -v &>"$LOGFILE" &

  local SS_CLIENT_PID=$!
  sleep 1
  if ! ps $SS_CLIENT_PID &>/dev/null; then
    error "could not start ss-local. check $LOGFILE for log"
    exit 2
  else
    info "started ss-local. see $LOGFILE for verbose log"
  fi

  sleep 5
  if curl ipinfo.io --proxy "socks5://127.0.0.1:$LOCAL_PORT" --max-time 10 ; then
    echo
    info "server at $SERVER_ADDR:$SERVER_PORT is working normally"
  else
    echo
    info "server at $SERVER_ADDR:$SERVER_PORT does not work"
  fi

  kill -9 $SS_CLIENT_PID
  wait &>/dev/null

  echo
  echo
}

if [[ $# -lt 4 ]]; then
  echo "USAGE: $0 ENC_METHOD PASSWORD SERVER_PORT [SERVER_ADDR]+"
  exit 1
fi

ENC_METHOD="$1"
PASSWORD="$2"
SERVER_PORT="$3"
while [[ $# -ge 4 ]]; do
  test-server "$ENC_METHOD" "$PASSWORD" "$SERVER_PORT" "$4" &
  wait
  shift
  LOCAL_PORT=$(( 1+LOCAL_PORT ))
done

