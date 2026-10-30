ARG CADDY_VERSION

FROM caddy:${CADDY_VERSION:-2.11}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4

FROM caddy:${CADDY_VERSION:-2.11}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
