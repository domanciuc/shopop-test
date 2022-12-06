FROM ruby:3.1.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /t1app
WORKDIR /t1app

ADD Gemfile /t1app/Gemfile
ADD Gemfile.lock /t1app/Gemfile.lock

RUN bundle install

ADD . /t1app