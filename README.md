# Supervisión en Elixir (ejemplo)

Ejemplo de supervisión en elixir. Consiste en un servidor sencillo que sirve HTML estático y un programa elixir que descarga HTML de una URL y retorna los títulos del documento.

## Content Server

Para correrlo:

```
$ cd content_server
$ npm install
$ node server.js
```

Requests de ejemplo:
   * `http://localhost:3000/foo` retorna un documento válido.
   * `http://localhost:3000/bar` simula un internal server error.
   * Cualquier otra URL da 404.


## Scraper

Para instalar dependencias y levantar una consola interactiva:

```
$ cd scraper
$ mix deps.get
$ iex -S mix
```

Una vez en la consola se debe levantar el supevisor y ya estamos listos para hacer pedidos:

```
> Scraper.Supervisor.start_link
> {:ok, titles} = Scraper.titles "http://localhost:3000/foo"
```

Si se quieren observar los procesor ejecutando en la Erlang VIM:

```
> :observer.start()
```
