FROM ruby:3.0.0
ENV LANG C.UTF-8
ENV DEBCONF_NOWARNINGS yes
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV XDG_CACHE_HOME /tmp
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTP_PROXY
EXPOSE 3000

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev

RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

RUN gem install rails

WORKDIR /work/backend
