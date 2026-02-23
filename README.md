# Verifica a sorpresa - Slim 4

Applicazione Slim 4 organizzata in modo modulare per esporre le 10 interrogazioni SQL su:
- `Fornitori(fid, fnome, indirizzo)`
- `Pezzi(pid, pnome, colore)`
- `Catalogo(fid, pid, costo)`

## Struttura

- `public/index.php`: bootstrap applicazione
- `config/settings.php`: configurazione DB (opzionale per estensioni future)
- `config/routes.php`: definizione endpoint
- `src/Infrastructure/Database/PdoFactory.php`: factory PDO (pronta per uso futuro)
- `src/Application/Repository/ExerciseRepository.php`: SQL delle 10 query
- `src/Application/Controller/ExerciseController.php`: endpoint JSON

## Setup rapido

1. Installa dipendenze (se necessario):
   - `composer install`
2. Rigenera autoload dopo modifiche namespace:
   - `composer dump-autoload`
3. Avvia server:
   - `php -S localhost:8080 -t public`
   - se hai errore "could not find driver", usa `./start.sh` (forza `/usr/bin/php`)

## Configurazione con phpMyAdmin (MySQL/MariaDB)

1. In phpMyAdmin crea un database, ad esempio `verificaasorpresa`.
2. Importa il file database.sql
3. Prima di avviare PHP, imposta le variabili ambiente:
   - `export DB_DRIVER=mysql`
   - `export DB_HOST=127.0.0.1`
   - `export DB_PORT=3306`
   - `export DB_NAME=verificaasorpresa`
   - `export DB_USER=root`
   - `export DB_PASS=`
4. Avvia l'app:
   - `php -S localhost:8080 -t public`

Nota: phpMyAdmin è l'interfaccia web; il database usato dall'app è MySQL/MariaDB via PDO.

## Endpoint

- `GET /` (lista delle 10 query)
- `GET /{id}` con `id` da 1 a 10

Esempio:
- `http://localhost:8080/1`