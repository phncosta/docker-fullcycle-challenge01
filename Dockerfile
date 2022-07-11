# start a golang base image, version 1.8
FROM golang:1.8-alpine as builder

WORKDIR /app

COPY main.go .

### Building the Go app for Linux OS, Crosscompiling disabled
RUN CGO_ENABLED=0 GOOS=linux go build ./main.go

# Scratch image -> no layers
FROM scratch

WORKDIR /app

COPY --from=builder /app .

CMD ["/app/main"]