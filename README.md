# Heroku Plugin Extending Config

Extends `heroku config` command-line to copy config variables between apps.

This extension aids in the situation where you have multiple environments for your application, and you've created your config variables for one "environment" already, and don't want to tediously type them up again.

## Installation

    $ heroku plugins:install https://github.com/set5think/heroku-config-copy.git

## Usage

    $ heroku config:copy --dst_app DST_APP (--app APP is is optional, pending you want to copy the config from the app that the heroku command will currently grab)

## Todo

Allow keys to be passed so only explicitly listed config variables get copied

## License

This plugin is released under the MIT license. See the file LICENSE.

## Copyright

Copyright &copy; 2013 Hassan Shahid.

[Contact]: mailto:set5think@gmail.com?subject=0Heroku%20Config%20Copy%20Plugin
