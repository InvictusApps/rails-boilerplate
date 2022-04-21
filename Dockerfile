FROM ruby:2.7.4

# Add repository necessary for postgresql-client-13
#RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#RUN wget -q -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -

# Update the package lists before installing.
RUN apt-get update -qq

# This installs
RUN apt-get install -y \
  build-essential \
  ca-certificates \
  netcat-traditional \
  vim \
  libpq-dev \
  postgresql-client-13 \
  nodejs \
  p7zip-full

# Install cron
RUN apt-get install -qq -y --no-install-recommends cron && \
  rm -rf /var/lib/apt/lists/*

ENV PORT 3000
ENV RAILS_ROOT /var/app/current
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Copy the Gemfile
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN mkdir -p tmp/pids

# Make sure we are running bundler version 2.0
RUN gem install bundler
RUN bundle install

COPY . .

RUN chmod +x entrypoint_api.sh

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]