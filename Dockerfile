ARG CADDY_VERSION

FROM caddy:${CADDY_VERSION:-2.11}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/fvbommel/caddy-combine-ip-ranges \
    --with github.com/mholt/caddy-l4

FROM caddy:${CADDY_VERSION:-2.11}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
