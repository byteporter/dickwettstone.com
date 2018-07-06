FROM jojomi/hugo AS build-site

ENV HUGO_THEME=coder
ENV HUGO_BASEURL=''
ENV HUGO_DESTINATION='/wettstone_output'

COPY ./site /src
RUN /run.sh

RUN ls /wettstone_output

FROM library/nginx:alpine
LABEL maintainer=james@byteporter.com

COPY --from=build-site /wettstone_output /usr/share/nginx/html

RUN ls /usr/share/nginx/html