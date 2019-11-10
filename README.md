# README

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
  rails s<br/>
  http://localhost:3000/<br/>

5) Запуск тестов<br/>
  rspec spec<br/>
