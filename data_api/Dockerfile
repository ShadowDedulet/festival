FROM ruby:3.0.3

ENV APP_PATH=/data
WORKDIR $APP_PATH

# устаналиваем гемы, необходимые приложению
COPY Gemfile* $APP_PATH/
RUN bundle install

# копируем код приложения
COPY . .

# сообщаем другим разработчикам и devopsам о том, на каком порту работает наше приложение
EXPOSE 3000

# устанавливаем команду по умолчанию
CMD ["rails", "server", "-b", "0.0.0.0"]