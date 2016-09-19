FROM alpine
MAINTAINER shouhei yamaguchi
EXPOSE 8080
RUN apk update
RUN apk add alpine-sdk ruby ruby-dev ruby-rdoc ruby-irb
RUN gem install io-console
RUN gem install bundler
RUN gem install puma
RUN apk del alpine-sdk
RUN mkdir /workspace
WORKDIR /workspace
ENV RACK_ENV production
CMD bundle install
CMD ["puma", "config.ru"]
