FROM library/node:8-alpine AS build-css

RUN set -x \
    && apk add --no-cache --virtual .build-deps make rsync \
    && npm install -g less uglifycss

COPY site /src

RUN set -x \
    && rsync -a --exclude 'themes' /src/ /src/themes/coder/ \
    && cd /src/themes/coder \
    # && cat static/less/colors.less \
    && make build \
    # && cat static/css/style.min.css \
    && rsync -a /src/themes/coder/static/css /src/static/

FROM jojomi/hugo AS build-site

ARG baseurl

ENV HUGO_THEME=coder
ENV HUGO_DESTINATION='/wettstone_output'
ENV HUGO_BASEURL=$baseurl

COPY site /src
COPY --from=build-css /src/static/css /src/static/css

RUN set -x \
    && /run.sh

# RUN ls /wettstone_output

FROM library/nginx:alpine
LABEL maintainer=james@byteporter.com

COPY --from=build-site /wettstone_output /usr/share/nginx/html

# RUN ls /usr/share/nginx/html