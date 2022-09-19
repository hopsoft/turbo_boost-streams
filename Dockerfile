FROM ruby:3.1.2

RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get -y --force-yes install build-essential git sqlite3 tzdata && \
apt-get clean

ENV RAILS_ENV=production

RUN gem update --system && gem install bundler
RUN git clone --origin github --branch main -–depth 1 https://github.com/hopsoft/turbo_ready.git /opt/turbo_ready
WORKDIR /opt/turbo_ready
RUN git pull github main
WORKDIR /opt/turbo_ready/test/dummy
RUN bundle --without test

CMD rm -f tmp/pids/server.pid && \
bin/rails db:create db:migrate && \
bin/rails log:clear && \
bin/rails assets:precompile && \
bin/rails s --binding=0.0.0.0 --port=3000
