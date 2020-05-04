FROM ruby:2.6.5-alpine

ENV RAILS_ENV development
ENV SECRET_KEY_BASE 123456789
ENV RAILS_MASTER_KEY cccf2d47e4bdac568774145b8067f661

# Install important dependencies
RUN apk add build-base nodejs yarn tzdata sqlite-dev postgresql-client postgresql-dev python imagemagick git nano --no-cache bash

RUN gem install bundler -v 1.16.1
RUN gem install rails -v '5.2.3'

RUN mkdir -p /myapp
RUN chmod -R 777 /myapp
WORKDIR /myapp

COPY Gemfile* /myapp/

RUN bundle install

COPY . /myapp/

RUN chmod -R 777 /myapp

RUN bin/rails assets:precompile

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

#ENTRYPOINT ["./lib/entrypoint.sh"]



