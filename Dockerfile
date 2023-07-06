# FROM ruby:3.0.0

# RUN bundle config --global frozen 1

# RUN mkdir /project1
# RUN gem install bundler

# WORKDIR /project1

# COPY Gemfile* ./

# RUN bundle install

# COPY . .

# # RUN adduser --disabled-login --gecos '' app
# # RUN chown -R app:app /app

# # USER app

# CMD ["rails", "server", "-b", "0.0.0.0"]

# FROM ruby:3.0.0

# WORKDIR /usr/src/app

# RUN apt-get update 

# WORKDIR /app

# RUN gem install mysql2

# COPY Gemfile* .

# RUN bundle install

# COPY . .

# FROM ruby:3.0.0

# RUN groupadd -r app && useradd -r -g app app

# RUN apt-get update && apt-get install -y \
#   build-essential \
#   default-mysql-client

# RUN mkdir /blogS
# WORKDIR /project1

# COPY Gemfile Gemfile.lock ./
# RUN bundle install

# COPY . .

# RUN chown -R app:app /project1

# USER app

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

# Используйте базовый образ Ruby
FROM ruby:3.0.0

# Установите зависимости для Rails
RUN apt-get update && apt-get install -y \
  build-essential \
  default-mysql-client \
  nodejs

# Создайте пользователя app
RUN useradd -ms /bin/bash app

# Установите рабочую директорию и переключитесь на пользователя app
WORKDIR /project1
USER app

# Установите гемы для Rails
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

# Скопируйте остальные файлы проекта
COPY . .

# Запустите приложение Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
