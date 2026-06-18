FROM ruby:4.0.5-alpine AS base

RUN apk add --update \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn

WORKDIR /home/app

FROM base AS dependencies

RUN apk add --no-cache --update build-base yaml-dev

COPY Gemfile Gemfile.lock ./

RUN bundle config set without "development test"
RUN bundle install --jobs=3 --retry=3
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile \
  && rm -rf ~/.yarn

FROM base

RUN adduser -D app
USER app

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/
COPY --chown=app --from=dependencies /home/app/node_modules/ node_modules/

COPY --chown=app . ./

RUN RAILS_ENV=production SECRET_KEY_BASE=assets bundle exec rake assets:precompile

CMD ["bundle", "exec", "rails s"]
