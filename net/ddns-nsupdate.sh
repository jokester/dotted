#!/bin/bash

## Watch change of public IP, and update DDNS (www.nsupdate.info) on need

set -u

MY_IP=""

# GET this URL updates your DDNS record
# This URL can be found at 
# ("Giving the http basic auth username and password in the URL:")
UPDATE_URL="https://XXXXXX.nerdpol.ovh:YYYYYY@www.nsupdate.info/nic/update"

update-ip () {
  date
  local PREV_IP="$MY_IP"
  MY_IP=`curl https://ipinfo.io/ip -s`
  if [[ "$MY_IP" = "$PREV_IP" ]] ; then
    echo "no need to update"
    return
  fi

  if curl -4 "$UPDATE_URL" ; then
    echo && echo "updated IPV4"
  else
    echo && echo "error updating IPV4"
  fi

  if curl -6 "$UPDATE_URL" ; then
    echo && echo "updated IPV6"
  else
    echo && echo "error updating IPV6"
  fi
}

while [[ 1 ]]; do
  update-ip
  # ipinfo.io have a rate limit of 1000req/24hr (roughly 40req/h). we use 12req/h
  sleep 300
done
