#!/bin/sh
ulimit -n 4096
sleep 30s
loops=1000
runs=300
for count in `seq ${runs}`;
do
  echo "Iter $count"
  crawl www.abcnews.com ${loops} &           >> /dev/null
  wait
  sleep 1m
done
echo "Finished..."
