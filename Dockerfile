FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    maude \
    graphviz \
    python3 \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/tamarin-prover/tamarin-prover/releases/download/1.10.0/tamarin-prover-1.10.0-linux64-ubuntu.tar.gz \
    && tar -xzf tamarin-prover-1.10.0-linux64-ubuntu.tar.gz \
    && chmod +x tamarin-prover \
    && mv tamarin-prover /usr/bin/tamarin-prover \
    && rm tamarin-prover-1.10.0-linux64-ubuntu.tar.gz

WORKDIR /thesis

COPY . .

RUN chmod +x verify_all.sh

ENTRYPOINT ["/bin/bash", "./verify_all.sh"]
