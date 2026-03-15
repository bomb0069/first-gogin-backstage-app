FROM golang:1.24-alpine AS build
WORKDIR /app
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -o server .

FROM gcr.io/distroless/static-debian12
WORKDIR /
COPY --from=build /app/server .
EXPOSE 8080
CMD ["/server"]
