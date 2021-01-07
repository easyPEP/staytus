FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY docker_entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker_entrypoint.sh
ENTRYPOINT ["docker_entrypoint.sh"]

EXPOSE 8787

# Start the main process.
CMD ["puma", "-C", "config/puma.rb"]
