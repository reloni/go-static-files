FROM golang:1.13.4-alpine3.10 as builder

ENV CGO_ENABLED=0 \
    GOPATH=/go \
    PATH=go/bin:$PATH
WORKDIR $GOPATH

RUN apk add --no-cache git && \
    go get "github.com/gorilla/mux"

ADD ./src ./src/app
RUN go install -i $GOPATH/src/app

FROM alpine:3.10
ENV CGO_ENABLED=0 \
    GOPATH=/go \
    PATH=go/bin:$PATH
WORKDIR $GOPATH

COPY --from=builder $GOPATH/bin/app $GOPATH/bin/
ADD ./static ./

EXPOSE 8080
USER 405

CMD ["./bin/app"]