FROM rust:latest as builder

WORKDIR /usr/src/app
COPY . .
ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y libpq5 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/app/target/release/rust-crud-api /usr/local/bin/rust-crud-api

CMD ["rust-crud-api"]
