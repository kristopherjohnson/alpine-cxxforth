FROM alpine

RUN apk update && apk add --no-cache libstdc++

# Get packages needed to download and build.
RUN apk add --no-cache --virtual .build-deps alpine-sdk cmake

RUN git clone https://github.com/kristopherjohnson/cxxforth.git

WORKDIR /cxxforth

RUN make targets optimized
RUN cp -f build/cxxforth /usr/local/bin/cxxforth
RUN cp -f build_optimized/cxxforth /usr/local/bin/cxxforth-fast

WORKDIR /

# Remove the build directory and sources.
RUN rm -rf /cxxforth

# Remove the packages we needed.
RUN apk del .build-deps \
  && rm -rf /var/cache/apk/*

CMD cxxforth

