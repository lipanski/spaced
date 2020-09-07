FROM ruby:2.7.1-alpine AS base

RUN apk add --update \
  postgresql-dev \
  sqlite-dev \
  libxml2 \
  libxslt \
  tzdata \
  nodejs \
  yarn

FROM base AS dependencies

# NOTE: Use system libxml2 and libxslt when install Nokogiri to speed up the build
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev

COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test'
RUN bundle install --jobs=3 --retry=3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM base

RUN adduser -D app
USER app
WORKDIR /home/app

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=app --from=dependencies /node_modules/ node_modules/
COPY --chown=app . ./

RUN RAILS_ENV=production SECRET_KEY_BASE=assets bundle exec rake webpacker:compile

CMD ["bin/start"]
