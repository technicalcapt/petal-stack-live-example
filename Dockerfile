# The version of Alpine to use for the final image
# This should match the version of Alpine that the elixir image uses internally
ARG ALPINE_VERSION=3.12

FROM elixir:1.11.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python3

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy all files wich is not excluded by .dockerignore
COPY . ./

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
RUN mix do deps.get, deps.compile

# build assets
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
RUN mix do compile, release

# prepare release image

FROM alpine:${ALPINE_VERSION} AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/peta_stack_example ./

ENV HOME=/app

COPY --chown=nobody:nobody ./docker-entrypoint.sh ./

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["./bin/peta_stack_example"]

# To seed data need to execute next command inside container:
# bin/peta_stack_example rpc "PetaStackExample.Seeder.seed_user_ratings"
# For example with docker-compose it will look like:
# docker-compose exec web bin/peta_stack_example rpc "PetaStackExample.Seeder.seed_user_ratings"
