# Spaced

A web app to improve your memory by using the spaced repetition method.

## Installation

Requirements:

- Ruby 2.5.3
- Postgres
- Yarn
- (Optional) SMTP credentials for sending out emails

Install application dependencies:

```sh
bundle install
```

Install frontend dependencies:

```sh
yarn install
```

Create a `.env` file from the available example and fill in the blanks:

```sh
cp .env.example .env
edit .env
```

Setup the databases:

```sh
bundle exec rake db:setup
```

Run the server:

```sh
bundle exec rails s
```

## Reference/Credits

- SuperMemo2 Algorithm: <https://www.supermemo.com/en/archives1990-2015/english/ol/sm2>
- <https://en.wikipedia.org/wiki/SuperMemo>
- <http://www.blueraja.com/blog/477/a-better-spaced-repetition-learning-algorithm-sm2>
- German to English Dictionaries: <https://github.com/hathibelagal/German-English-JSON-Dictionary>

---

Copyright (C) Florin Lipan, 2020
