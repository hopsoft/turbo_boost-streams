FROM ruby:3.2.2-slim-bullseye

RUN apt-get -y update && \
apt-get -y --no-install-recommends install \
build-essential \
curl \
libjemalloc2 \
sqlite3 \
tzdata

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get -y --no-install-recommends install nodejs
RUN apt-get clean
RUN gem update --system && gem install bundler
RUN npm install -g yarn

COPY . /opt/turbo_boost-streams

CMD /opt/turbo_boost-streams/bin/docker/run
