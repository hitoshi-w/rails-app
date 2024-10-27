FROM ruby:3.3-alpine AS builder
ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
WORKDIR $APP_ROOT
RUN apk update && \
    apk add --no-cache \
        gcc \
        git \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        postgresql \
        postgresql-dev \
        tzdata && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev && \
    apk del build-packs
COPY Gemfile Gemfile.lock .
COPY entrypoint.sh /usr/bin/
RUN gem install --no-document bundler && bundle install
RUN chmod +x /usr/bin/entrypoint.sh

FROM builder AS development
ENV RAILS_ENV=development
WORKDIR $APP_ROOT
COPY . .
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]



