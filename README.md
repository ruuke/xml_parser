# README
Приложение позволяет загружать в базу данных информацию о списке посылок, накладной, содержании посылок и товарах<br/>
Файлы для тестов можно взять здесь - spec/support/assets

1) Установить БД<br/>
  sudo apt-get install postgresql<br/>
  sudo apt-get install libpq-dev<br/>
  sudo -u postgres psql<br/>
  sudo apt-get install libv8-dev<br/>
  sudo apt-get install nodejs<br/>

  CREATE ROLE <USERNAME> LOGIN<br/>
  ENCRYPTED PASSWORD 'qwerty123'<br/>
  NOSUPERUSER NOINHERIT CREATEDB NOCREATEROLE;<br/>

  postgres=#\q<br/>

2) Установить гемы<br/>
  bundle install<br/>

3) Создать БД<br/>
  $ rake db:setup<br/>
  $ rake db:migrate<br/>

4) Запуск приложения<br/>
  sudo apt-get install redis-server<br/>
  rails s<br/>
  sidekiq<br/>
  http://localhost:3000/<br/>

5) Запуск тестов<br/>
  rspec spec<br/>
