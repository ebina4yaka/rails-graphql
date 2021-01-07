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
  lsb-release

RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update && apt-get install -y yarn postgresql-client-13 libpq-dev

RUN yarn global add @2fd/graphdoc

RUN gem install rails

WORKDIR /work/backend
