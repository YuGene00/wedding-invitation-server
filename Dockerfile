FROM golang:1.18 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
ENV CGO_ENABLED=0
RUN go build -o server .

FROM alpine:3.22

WORKDIR /app
COPY --from=builder /app/server .

CMD ["./server"]
