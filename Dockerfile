FROM ruby:3.2.2

RUN mkdir /mini-indexer
WORKDIR /mini-indexer

COPY Gemfile /mini-indexer/Gemfile
COPY Gemfile.lock /mini-indexer/Gemfile.lock

RUN bundle install && bundle update --bundler

COPY . /mini-indexer
