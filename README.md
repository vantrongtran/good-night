# GoodNight

## Prerequisites

You need to install all of this before moving to next step.

* [Git](http://git-scm.com/)
* [Docker](https://www.docker.com/)

## Installation

```bash
$ docker-compose build
$ docker-compose up -d
$ docker-compose run app db:create db:migrate
```

## Environment

DB_NAME
DB_PORT
DB_USERNAME
DB_PASSWORD
DB_HOST_NAME

And then, API server should be running on your [http://localhost:3000](http://localhost:3000)

**IMPORTANT!**

In case of you want to use rails, rails command without docker or run RSpec. Setup local environment variable.
You can also keep any sensitive information here.

## Login to server
```bash
$ docker-compose exec app bash -it
```

## Debugger/Rails log
```bash
$ docker attach good-night_app_1
```

## Master Data

Login to server and running following command:
```bash
$ docker-compose run app rails db:migrate
$ docker-compose run app rails db:seed
```
## Run rspec, rubocop before push code
```bash
$ docker-compose run app rubocop
$ docker-compose run app rspec
```
