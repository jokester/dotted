#!/usr/bin/env bash

set -u

if [[ 0 -eq "$#" ]]; then
  echo "Test ttfb and stuff of GET request"
  echo "    USAGE: $0 URL{2,} # GET each URL once (NOTE: reuse of TCP connection may distort timings)"
  echo "    USAGE: $0 URL     # GET twice (reusing the same connection) to test SSL overhead"
  exit 1
fi

TEMPLATE=$(cat <<END
\n
| URL: %{url_effective}
| DNS lookup: %{time_namelookup} | TCP Connect: %{time_connect} | SSL handshake done: %{time_appconnect} | TTFB: %{time_starttransfer}
| Total time: %{time_total} | Avg Speed: %{speed_download} B/s
\n
END
)

if [[ 1 -eq "$#" ]]; then
  curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -vv -s -k --compressed \
    -w "$TEMPLATE"  \
    "$1" "$1"
  exit 0
fi

for url in "$@"; do
  curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -vv -s -k --compressed \
    -w "$TEMPLATE" \
    "$url"
done
