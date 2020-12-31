FROM ruby:3.0.0-buster
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /usr/src/app
COPY . .
RUN bundle install
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
