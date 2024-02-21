FROM ruby:3.3.0-alpine

RUN apk add --no-cache build-base postgresql-dev postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN mkdir -p /app/log

COPY . .

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
