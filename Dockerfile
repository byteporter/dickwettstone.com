FROM jojomi/hugo AS build-site

ARG baseurl

ENV HUGO_THEME=coder
ENV HUGO_DESTINATION='/wettstone_output'
ENV HUGO_BASEURL=$baseurl

COPY ./site /src
RUN set +x && \
    /run.sh

RUN ls /wettstone_output

FROM library/nginx:alpine
LABEL maintainer=james@byteporter.com

COPY --from=build-site /wettstone_output /usr/share/nginx/html

RUN ls /usr/share/nginx/html