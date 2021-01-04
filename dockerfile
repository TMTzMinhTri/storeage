FROM ruby:3.0.0-buster
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /usr/src/app
ADD Gemfile Gemfile.lock /usr/src/app/
RUN bundle install
COPY . .
EXPOSE 8000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8000"]

