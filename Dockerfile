FROM golang:1.16.4-alpine3.13 AS builder

ARG VERSION=dev

WORKDIR /go/src/app
COPY main.go .
RUN go build -o main -ldflags=-X=main.version=${VERSION} main.go

FROM debian:buster-slim
COPY --from=builder /go/src/app/main .
ENV PATH="/go/bin:${PATH}"
CMD ["main"]