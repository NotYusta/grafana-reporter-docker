FROM debian:bookworm-slim

LABEL maintainer="Muhammad Yudha Abhista"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        texlive-latex-base && \
    rm -rf /var/lib/apt/lists/* /tmp/*


RUN curl -sLo /usr/local/bin/grafana-reporter \
        https://github.com/IzakMarais/reporter/releases/download/v2.3.1/grafana-reporter && \
    chmod +x /usr/local/bin/grafana-reporter

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
