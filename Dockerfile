FROM caddy:2-alpine
WORKDIR /srv
COPY index.html manifest.json sw.js /srv/
COPY *.png /srv/
COPY Caddyfile /etc/caddy/Caddyfile
