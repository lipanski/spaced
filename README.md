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
bundle Install
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

## References/Credits

- Source for the German to English dictionaries: <https://github.com/hathibelagal/German-English-JSON-Dictionary>
