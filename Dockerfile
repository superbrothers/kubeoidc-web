FROM golang:1.10 AS builder
WORKDIR /go/src/app
COPY . .
RUN go build -o /usr/bin/kubeoidc-web .

###############################################

FROM ubuntu:24.04
RUN set -x && \
    apt update && apt -y install ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/bin/kubeoidc-web /usr/bin/kubeoidc-web
CMD ["/usr/bin/kubeoidc-web"]
