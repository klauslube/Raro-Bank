FROM ruby:3.2.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client curl

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
RUN bundle install
RUN yarn install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
