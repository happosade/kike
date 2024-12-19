FROM golang:latest AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build -o main ./cmd/main.go

# Expose the port
EXPOSE 8080

# Run the application
CMD ["./main"]

FROM scratch
COPY --from=build /app/main main
EXPOSE 8080

CMD [ "./main" ]