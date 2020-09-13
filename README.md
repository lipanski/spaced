# Spaced

Spaced is a web app that helps you memorize anything that fits on a flash card. The project makes use of the [spaced repetition technique](https://en.wikipedia.org/wiki/Spaced_repetition). Every day you'll be presented with a deck of cards. Difficult cards will show up more often than the easier ones. You can use this technique to learn foreign words, phone numbers, historical facts, medical terms, programming languages, keyboard shortcuts.

Spaced is a pet project and it's also my Ruby on Rails playground. It's where I try out new concepts and show case some of the [best practices](https://github.com/lipanski/spaced/search?q=%22%23+NOTE%22&unscoped_q=%22%23+NOTE%22) I know. The hosted version of the project comes with no guarantees whatsoever, but I'll do my best to keep the server running. You can always run your own version under the GPL-3.0 license.

Browse to <https://spaced.lipanski.com> for the hosted version or read on, if you'd like to run your own server.

## Installation

The project requires the following **dependencies**:

- Ruby
- Postgres
- Yarn
- Optional: SMTP credentials for sending out emails

You can find the **exact versions** inside the [`.tool-versions`](https://github.com/lipanski/spaced/blob/master/.tool-versions) file and I recommend using [asdf](https://asdf-vm.com/) to install all these dependencies in one go:

```
asdf plugin add ruby
asdf plugin add nodejs
asdf plugin add postgres

POSTGRES_EXTRA_CONFIGURE_OPTIONS="--with-openssl" asdf install
```

**Setup** the project:

```sh
bin/setup
```

> This will create a `.env` file within your project directory. This file allows you to configure your local environment, though the defaults should be a good start for a development server.

**Run** the server:

```sh
bin/start
```

## Deploying to production

The project provides a [`Dockerfile`](https://github.com/lipanski/spaced/blob/master/Dockerfile) which is tailored for running a production sever. You can configure it via environment variables. Have a look inside [`.env.example`](https://github.com/lipanski/spaced/blob/master/.env.example) for the full list of variables.

You can build the production Docker image by running:

```sh
docker build -t spaced .
```

...and you can try it out inside your development environment by running:

```
docker run -it --rm --net=host --env-file .env -e "RAILS_ENV=production" -e "SPACED_DB_USER=$USER" -e "SPACED_DB_NAME=spaced_development" spaced
```

## Tests

Run **all** tests:

```sh
bundle exec rake
```

...or just the **unit/controller** tests:

```sh
bundle exec rake test
```

...or just the **system** tests - by default they run in headless Firefox:

```sh
bundle exec rake test:system
```

...or just the **Rubocop** checks:

```sh
bundle exec rake rubocop
```

## Reference/Credits

- SuperMemo2 Algorithm: <https://www.supermemo.com/en/archives1990-2015/english/ol/sm2>
- <https://en.wikipedia.org/wiki/SuperMemo>
- <http://www.blueraja.com/blog/477/a-better-spaced-repetition-learning-algorithm-sm2>
- German to English Dictionaries: <https://github.com/hathibelagal/German-English-JSON-Dictionary>

---

Copyright (c) Florin Lipan, 2020
