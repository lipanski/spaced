FROM ruby:2.5.3-alpine AS base

RUN apk add --update \
  postgresql-dev \
  sqlite-dev \
  tzdata \
  nodejs

FROM base AS dependencies

RUN apk add --update \
  build-base \
  yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

COPY package.json yarn.lock ./
RUN yarn install

FROM base

RUN adduser -D app
USER app
WORKDIR /home/app

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=app --from=dependencies /node_modules/ node_modules/

# Copy all resources required for precompiling assets
COPY --chown=app Gemfile Gemfile.lock Rakefile ./
COPY --chown=app app/assets app/assets
COPY --chown=app config/initializers config/initializers
COPY --chown=app config/environments config/environments
COPY --chown=app config/application.rb config/boot.rb config/environment.rb config/
COPY --chown=app vendor vendor

# Precompile assets
RUN RAILS_ENV=production SECRET_KEY_BASE=assets bundle exec rake assets:precompile

COPY --chown=app . ./

CMD ["bin/start"]
