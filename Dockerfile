FROM ruby:latest

WORKDIR /omniauth-booker
ADD Gemfile /omniauth-booker
ADD omniauth-booker.gemspec /omniauth-booker
ADD lib/omniauth/booker/version.rb /omniauth-booker/lib/omniauth/booker/version.rb

RUN bundle install -j8

ADD . /omniauth-booker/

ENV DOCKER=true
