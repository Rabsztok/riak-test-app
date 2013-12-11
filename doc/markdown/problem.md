## Geneza problemu

### 8Merch.com
8Merch.com jest serwisem internetowym umożliwiającym niezależnym muzykom stworzenie sklepu internetowego wraz z obsługą serwisów społecznościowych.
Jedną z kluczowych funkcji oferowanych przez platformę jest możliwość streamingu plików audio w sklepach muzyków.

### Skalowalność
W związku z powstawaniem kolejnych sklepów i co za tym idzie bazy plików audio, postanowiliśmy zmienić dotychczasową architekturę na oferującą lepszą skalowalność.
Postanowiliśmy zbadać wydajność pod zróżnicowanym obciążeniem w wypadku składowania plików w bazie danych Riak. By test był miarodajny, postanowiliśmy poddać testom także rozwiązanie oparte na bazie danych mysql - czyli bazę obecnie stosowaną w aplikacji 8merch.
Nasze obawy przede wszystkim dotyczą opóźnień w dostępie do danych, prowadzących do rosnącego niezadowolenia użytkowników.

### Niezawodność
Elementem motywującym do migracji plików do bazy danych Riak, jest także fakt zapewnienia przez nią dużo lepszej ochrony danych oraz możliwość wykorzystania kilku serwerów do zbudowania chmury, w której każda maszyna odpowiadałaby jednemu węzłowi bazy danych, zapewniając niezwykle wysoką niezawodność systemu.
Obecna metoda przechowywania danych, polega na przechowywaniu plików na pojedyńczym serwerze, wraz z cyklicznymi backupami przy pomocy programu rsync.
Rozwiązanie to z pewnością w niedługim czasie doprowadzi do problemu w postaci niewystarczającej przestrzeni dyskowej. Uzyskanie dostępu do plików przechowywanych na kilku maszynach wymaga dedykowanego rozwiązania, które Riak oferuje w standardzie.

## Aplikacja testująca bazy danych

### Założenia ogólne
Stworzony przez nas benchmark składa się z aplikacji napisanej w Ruby On Rails, posiadającej interfejs pozwalający przeglądać, odsłuchiwać oraz pobierać pliki audio.
Aplikacja zbudowana została w standardzie REST, posiada ona 3 zasoby reprezentujące pliki audio, każdy odpowiadający odrębnej bazie danych.

### Obsługa plików
Za obsługę wysyłania plików w aplikacji Railsowej odpowiada gem Carrierwave. Jego niezaprzeczalną zaletą jest wsparcie dla dużej ilości metod składowania danych, co pozwoliło na zunifikowanie metody wysyłania plików przez aplikację na serwer.

### Generowanie zawartości
Do stworzenia plików audio wykorzystywanych w testach użyliśmy skryptu, wykonywanego asynchronicznie przez SideKiq. Pozwoliło to na generowanie dowolnie dużego zbioru danych w formacie wav, w zależności od chwilowej potrzeby.
Skrypt polega na generowaniu losowego tekstu o długości ok. 6 zdań a następnie przekazaniu go do syntezatora mowy espeak, zwracającego porządany plik dźwiękowy w formacie wav.

### Frontend
Do stworzenia estetycznego frontendu użyliśmy frameworku Twitter Bootstrap. Dzięki niemu udało się osiągnąć w niedługim czasie zadowalający efekt wizualny.