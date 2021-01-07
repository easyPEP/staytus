# see: https://docs.docker.com/compose/rails/

FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install

COPY . /usr/src/app

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh

COPY dockercompose-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/dockercompose-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8787

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["bundle exec", "puma", "-C", "config/puma.rb"]
