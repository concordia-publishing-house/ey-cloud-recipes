Heroku-style database.yml file
==============================

A chef recipe for writing a custom database.yml file for [EY Cloud].

The resulting file will be found at `/data/<app_name>/shared/config/database.yml` and it will assume that there is a DATABASE_URL variable in your environment.

[EY Cloud]: https://cloud.engineyard.com/extras
