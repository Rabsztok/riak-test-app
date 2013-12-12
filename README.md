# Aplikacja testująca wydajność pobierania plików audio dla bazy danych Riak, MongoDB oraz MySQL.

## Instalacja

Zainstaluj zależności:

    [sudo] apt-get install redis-server mysql-server espeak

Stwórz bazę danych Riak oraz MongoDB, wskazówki możesz znaleźć w wiki tego repozytorium.

Pobierz gemy:

    bundle install

Stwórz bazę danych MySQL:

    bundle exec rake db:create

Wykonaj migracje:

    bundle exec rake db:migrate

## Uruchomienie

Uruchom serwer aplikacji Ruby on Rails:

    rails s

Uruchom Sidekiq jeśli chcesz generować pliki audio:

    bundle exec sidekiq
