FROM elixir-1.12.1-alpine AS build

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install phx_new 1.5.9 --force

# set build ENV
ENV MIX_ENV=dev

COPY . .

RUN mix do deps.get, deps.compile

CMD ["/bin/sh", "-c", "mix phx.server"]