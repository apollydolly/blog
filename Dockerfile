FROM ruby:3.0.0

# RUN bundle config --global frozen 1
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  libpq-dev \
  default-mysql-client

# WORKDIR /usr/src/app
WORKDIR /project1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# RUN groupadd -r app && useradd -r -g app app
RUN adduser --disabled-login --gecos '' app
RUN chown -R app:app /project1

USER app

CMD ["rails", "server", "-b", "0.0.0.0"]
