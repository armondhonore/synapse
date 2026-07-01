FROM mirror.gcr.io/library/rust:slim AS builder
WORKDIR /app
COPY _app/ .
RUN cargo build --release --bin nexlayer_app

FROM mirror.gcr.io/library/debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app/target/release/nexlayer_app /app/server
EXPOSE 8080
CMD ["/app/server"]
