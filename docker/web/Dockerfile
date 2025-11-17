# Base image: Use Alpine-based nginx (smaller and more stable)
FROM nginx:1.27-alpine

# Install dependencies (Alpine uses apk instead of apt)
RUN apk add --no-cache apache2-utils bash

# Certbot for SSL certificates
RUN apk add --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    libffi-dev \
    gcc \
    musl-dev \
    augeas-libs \
    augeas-dev \
    openssl-dev

RUN python3 -m venv /opt/certbot/
RUN /opt/certbot/bin/pip install --upgrade pip
RUN /opt/certbot/bin/pip install certbot certbot-nginx
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot

# establish where Nginx should look for files
ENV RAILS_ROOT /var/www/app

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log

# copy over static assets
COPY public public/

# Copy Nginx config template
COPY docker/web/nginx.conf /tmp/docker.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
