# sync-engine-docker

Community-developed utilities to run the [Nylas Sync Engine](https://github.com/nylas/sync-engine-docker) under Docker. Note this is not officially supported by Nylas. (We use [Debian packages to deploy code](https://nylas.com/blog/packaging-deploying-python/).)

## Configuring

## Install

    docker-compose up -d
    docker-compose run --rm api ./bin/create-db
    docker-compose run --rm api bin/inbox-auth [youremail]

## Using with N1

See https://github.com/nylas/N1/blob/master/CONTRIBUTING.md#running-against-open-source-sync-engine
