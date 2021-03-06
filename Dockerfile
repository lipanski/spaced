FROM ruby:2.7.1-alpine AS base

RUN apk add --update \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn

FROM base AS dependencies

RUN apk add --update build-base

COPY Gemfile Gemfile.lock ./
RUN bundle config set without "development test"
RUN bundle install --jobs=3 --retry=3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM base

EXPOSE 3000

RUN adduser -D app
USER app
WORKDIR /home/app

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=app --from=dependencies /node_modules/ node_modules/
COPY --chown=app . ./

RUN RAILS_ENV=production SECRET_KEY_BASE=assets bundle exec rake assets:precompile

CMD ["bin/start"]
