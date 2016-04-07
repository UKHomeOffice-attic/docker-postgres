# docker-postgres
base docker image with postgres

## Usage

This docker container is intended to be built upon in projects requiring Postgres.

### Configuration
In your Dockerfile you can overwrite the default configuration by copying a file to /conf/postgres.conf

For example:
COPY postgresql.conf /conf/postgresql.con

The entrypoint will automatically copy this to the postgres configuration directory after the db has been initialized

## Contributing

Feel free to submit pull requests and issues. If it's a particularly large PR, you may wish to
discuss it in an issue first.

Please note that this project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

## Versioning

We use [SemVer](http://semver.org/) for the version tags available See the tags on this repository.

## License

This project is licensed under the GPL v2 License - see the
[LICENSE.md](LICENSE) file for details
