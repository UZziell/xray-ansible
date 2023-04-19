#!/bin/sh

MIN_SIZE=5
MAX_SIZE=10
LIMIT=1500000

IPS="$IPS 37.156.53.179 103.153.254.110 151.243.124.13 217.218.2.88 194.225.222.79 78.39.205.170 80.191.47.231"
SIZE=$(shuf -i $MIN_SIZE-$MAX_SIZE -n 1)
DST_IP=$(shuf -n1 -e $IPS)
DST_PORT=$(shuf -i 1024-65535 -n1)

echo "B: $(date +%M) $SIZE $DST_IP $DST_PORT" | sed 's:\.: :g'
dd if=/dev/urandom bs=1024000 count="$SIZE" 2>/dev/null | pv --quiet -L "$LIMIT" | timeout 45 nc -u "$DST_IP" "$DST_PORT" # pv --rate --timer --bytes
echo "E: $(date +%M) $SIZE $DST_IP $DST_PORT" | sed 's:\.: :g'
