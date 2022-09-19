FROM ruby:3.1.2

RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get -y --force-yes install build-essential tzdata && \
apt-get clean

COPY . /opt/turbo_ready
WORKDIR /opt/turbo_ready/test/dummy

VOLUME /usr/local/bundle
RUN rm -f Gemfile.lock && \
gem update --system && \
bundle config unset force_ruby_platform && \
bundle --without test
RUN bundle lock --add-platform aarch64-linux && \
bundle lock --add-platform x86_64-linux

ENV RAILS_ENV=production
CMD rm -f tmp/pids/server.pid && \
bin/rails db:create db:migrate && \
bin/rails log:clear && \
bin/rails assets:clobber && \
bin/rails assets:precompile && \
bin/rails s --binding=0.0.0.0 --port=3000
