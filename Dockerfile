#applicationのディレクトリ名で置き換えてください
ARG APP_NAME=VtourHubAdmin
#使いたいrubyのimage名に置き換えてください
ARG RUBY_IMAGE=ruby:3.1.2
#使いたいnodeのversion
ARG NODE_VERSION='16'
#インストールするbundlerのversionに置き換えてください
ARG BUNDLER_VERSION=2.3.17

FROM $RUBY_IMAGE
ARG APP_NAME
ARG NODE_VERSION
ARG RUBY_VERSION
ARG BUNDLER_VERSION

ENV RAILS_ENV production
ENV BUNDLE_DEPLOYMENT true
ENV BUNDLE_WITHOUT development:test
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

# 別途インストールが必要なものがある場合は追加してください
RUN apt-get update -qq && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn

RUN gem install bundler:$BUNDLER_VERSION

COPY Gemfile /$APP_NAME/Gemfile
COPY Gemfile.lock /$APP_NAME/Gemfile.lock

RUN bundle install

COPY yarn.lock /$APP_NAME/yarn.lock

COPY . /$APP_NAME/

RUN yarn install --production --frozen-lockfile
RUN yarn cache clean

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
