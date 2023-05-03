FROM ruby:3.2.2-slim-bullseye

RUN apt-get -y update && \
apt-get -y --no-install-recommends install \
build-essential \
curl \
git \
sqlite3 \
tzdata

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

RUN rm -rf /opt/turbo_boost-streams && \
git clone --origin github --branch main --depth 1 https://github.com/hopsoft/turbo_boost-streams.git /opt/turbo_boost-streams && \
mkdir -p /opt/turbo_boost-streams/node_modules

WORKDIR /opt/turbo_boost-streams

RUN yarn
RUN bundle

CMD git pull --depth 1 && \
yarn && \
bundle && \
cd test/dummy && \
rm -rf tmp/pids/*.pid && \
bin/rails assets:clean assets:precompile && \
bin/rails s --binding=0.0.0.0 --port=3000
