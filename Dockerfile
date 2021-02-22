FROM lacework/datacollector:latest-sidecar as laceworkagent
FROM ubuntu:18.04
COPY --from=laceworkagent /var/lib/lacework-backup /var/lib/lacework
RUN apt-get update && apt-get install dnsutils curl jq -y && apt-get clean
COPY crawl /usr/bin/crawl
COPY run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/crawl && \
    chmod +x /usr/bin/run.sh && \
    echo "New Test" && \
    mkdir -p /var/lib/lacework/config && \
    echo '{ "tokens": {"accesstoken":"YourAccessToken"}}' > /var/lib/lacework/config/config.json
CMD ["sh", "-c", "/var/lib/lacework/lacework-sidecar.sh && /usr/bin/run.sh"]
