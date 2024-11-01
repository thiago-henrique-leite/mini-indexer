FROM ruby:3.2.2-alpine AS ruby-base

RUN apk add \
  bash \
  build-base \
  postgresql-dev \
  postgresql-client \
  libxslt-dev \
  libxml2-dev \
  tzdata

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./Gemfile* ./
RUN bundle install

FROM ruby-base

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

EXPOSE 3000
