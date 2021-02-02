FROM ruby:2.7.1

# JS Runtime and PG dependencies
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  default-libmysqlclient-dev \
  default-mysql-client \
  redis-tools && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Clean!
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create work dir
ENV APP_ROOT /opt/webapp
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Install Ruby package
COPY Gemfile Gemfile.lock /tmp/
RUN cd /tmp && bundle
RUN gem install foreman

ADD . $APP_ROOT
