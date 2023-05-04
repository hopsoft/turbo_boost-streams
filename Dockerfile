FROM ruby:3.2.2-slim-bullseye

RUN apt-get -y update && \
apt-get -y --no-install-recommends install \
build-essential \
curl \
libjemalloc2 \
sqlite3 \
tzdata

ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

# NOTE: all the `lib*` and `zlib*` packages are required for Microsoft's Playwright
RUN apt-get -y update && \
apt-get -y --no-install-recommends install \
nodejs \
libasound2 \
libatk-bridge2.0-0 \
libatk1.0-0 \
libc6 \
libcairo-gobject2 \
libcairo2 \
libcups2 \
libdbus-1-3 \
libexpat1 \
libfontconfig1 \
libfreetype6 \
libgbm1 \
libgdk-pixbuf2.0-0 \
libglib2.0-0 \
libgtk-3-0 \
libnss3 \
libpango-1.0-0 \
libpangocairo-1.0-0 \
libstdc++6 \
zlib1g

RUN apt-get clean

# setup ruby gems
RUN gem update --system && gem install bundler

# setup yarn
RUN npm install -g yarn

COPY . /opt/turbo_boost-streams

CMD /opt/turbo_boost-streams/bin/docker/run
