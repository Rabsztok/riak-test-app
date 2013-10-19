# Instalacja i konfiguracja

Instrukcja instalacji dotyczy systemów z rodziny Debian i Ubuntu, instrukcje instalacji na innych systemach operacyjnych są szczegółowo opisane na stronie http://docs.basho.com/riak/latest/

## Instalacja bazy Riak

Pierwszym krokiem instalacji projektu jest zainstalowanie pakietów niezbędnych do używania bazy Riak.
Do ich instalacji użyty został menedżer pakietów systemu debian apt-get:

    $ sudo apt-get install erlang build-essential libc6-dev-i386 git

Samą bazę danych postanowiliśmy skompilować ze źródła używając następującyh kroków:

    $ wget http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.2/riak-1.4.2.tar.gz
    $ tar zxvf riak-1.4.2.tar.gz
    $ cd riak-1.4.2
    $ make rel

To czy instalacja przebiegła pomyślnie, można sprawdzić uruchamiając testowy węzeł i komendę ping:

    $ riak start
    $ riak ping
    => pong

## Konfiguracja bazy Riak

Konfigurację przeprowadzamy w katalogu w którym wcześniej kompilowaliśmy Riaka, korzystając z programu Rebar stworzymy klaster składający się z 5 węzłów.

Tworzymy węzły:

    $ make devrel DEVNODES=5

Powyższa komenda stworzyła w obecnym katalowu folder dev zawierający nowo utworzone węzły:

    $ cd dev; ls
    => dev1       dev2       dev3       dev4       dev5

Następnie uruchamiamy każdy węzeł z osobna:

    $ dev1/bin/riak start
    $ dev2/bin/riak start
    $ dev3/bin/riak start
    $ dev4/bin/riak start
    $ dev5/bin/riak start

Podczas tworzenia węzłów możemy otrzymać komunikat zalecający zwiększenie limitu otwartych deskryptorów (ulimit). Zgodnie z zaleceniem zwiększamy limit:

    $ ulimit -n 4096

Tworzymy następnie klaster - dołączamy węzły od 2 do 5 do pierwszego węzła:

    $ dev2/bin/riak-admin cluster join dev1@127.0.0.1
    $ dev3/bin/riak-admin cluster join dev1@127.0.0.1
    $ dev4/bin/riak-admin cluster join dev1@127.0.0.1
    $ dev5/bin/riak-admin cluster join dev1@127.0.0.1

Dokonujemy przeglądu planu i zatwierdzamy powyższe zmiany:

    $ dev1/bin/riak-admin cluster plan
    $ dev1/bin/riak-admin cluster commit

Teraz, gdy dysponujemy już działającym klastrem, możemy sprawdzić, czy działa on poprawnie komendą:

    $ dev1/bin/riak-admin member-status