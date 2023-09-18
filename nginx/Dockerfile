FROM nginx:stable

ARG TZ=UTC
ENV TZ ${TZ}

# Set the timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the self-signed certificates
ADD ./includes/.certs /etc/nginx/conf.d/dockerhero/certs

# Add the core configuration
ADD ./includes/.conf /etc/nginx/conf.d/dockerhero/core

# Overwrite the default.conf with our version
COPY ./includes/.conf/default.conf /etc/nginx/conf.d/default.conf

# Remove the old mime types
RUN rm /etc/nginx/mime.types

# Add the new mime types
COPY ./includes/.mime/mime.types /etc/nginx/mime.types
