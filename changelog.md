# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

- nothing


## 1.4.0 - 2019-05-14

This is a pretty major release that sets PHP 7.2 as the default version for both the PHP and the Workspace container.
If you are not ready yet for this change, you can roll back to PHP 7.1 by adding a `docker-composer.override.yml` with
the following contents:

```
version: '2'

services:
  php:
	image: johanvanhelden/dockerhero-php-7.1-fpm:latest

  workspace:
	image: johanvanhelden/dockerhero-workspace:php7.1
```

### Changed

- Update to PHP 7.2 (workspace image)
- Set PHP 7.2 as the default version for the PHP image
- Switched to a development version of PHPMyAdmin (5.0.0-dev) to have an upgraded jQuery version (CVE-2019-11358)

## 1.3.2 - 2019-01-07

### Changed

- Updated PHPMyAdmin version to 4.8.4

### Added

- PHP 7.3 image

## 1.3.1 - 2018-09-04

### Changed

- Increased the default upload size from 8m to 64m in the nginx image.

## 1.3.0 - 2018-09-04

### Changed

- The default MySQL version is now 5.7

### Added

- Added sections to the readme on how to change the MySQL version and SQL mode.
- Added a known issues section to the readme with a known MacOS issue.

## 1.2.6 - 2018-07-17

### Changed

- Node 8 is now the default version in the workspace image.

### Added

- bcmath extension to the workspace, php 7.1 and php 7.2 image

## 1.2.5 - 2018-07-16

### Changed

- Expose the default laravel-dump-server port for the PHP image.
- Expand the readme's ToC and restructure it.

### Added

- Include a section in the readme with help on how to make the laravel-dump-server work

## 1.2.4 - 2018-05-03

### Added

- mysql-client to the workspace, php 5.6, php 7.1 and php 7.2 image

## 1.2.3 - 2018-03-15

### Added

- PHP 7.2 image
- Include a section in the readme with help on how to make Laravel work with Dockerhero's default "public_html" setting

## 1.2.2 - 2018-02-13

### Added

- PHP 5.4 image

## 1.2.1 - 2018-01-10

### Added

- PHP imap extention to the workspace image

## 1.2.0 - 2018-01-05

### Changed

- Made PHP 7.1 the default version.
- Rebuild workspace and PHP 7.1 images (updated PHP 7.1 to 7.1.12 and Yarn to 1.3.2).

## 1.1.5 - 2017-05-01

### Added

- A PHP 7.1 container option.

## 1.1.4 - 2017-03-21

### Added

- Redis PHP extension (php and workspace image) - @pkeulers.
- Proper sendmail path to mailhog in php.ini (php image) - this will allow crons to send mail as well.
- phpRedisAdmin (<http://phpredisadmin.localtest.me>)

## 1.1.3 - 2017-03-04

### Added

- A redis container.
- Instructions on how to make a local website publicly available using ngrok.

## 1.1.2 - 2017-02-10

### Added

- Chrome in order to support Laravel Dusk. (workspace image)
- A using Laravel Dusk section to the readme.

### Changed

- Ignore docker-compose.override.yml file - in order to make it easy to make changes to settings.
- No longer force SSL. (nginx image)
- Better explanation on how to connect to projects from within containers in the readme.

## 1.1.1 - 2017-01-25

### Added

- Subdomain support. (nginx image)

## 1.1.0 - 2017-01-20

### Changed

- Update to PHP 7.1 (workspace image)

## 1.0.7 - 2017-01-20

### Added

- Yarn (workspace image)

## 1.0.6 - 2017-01-06

### Added

- PHP zip extension. (php-5.6-fpm image)
- Section to the readme on how to forward requests to nginx container from PHP.

## 1.0.5 - 2016-12-05

### Added

- Laravel Artisan autocompletion. (workspace image)

## 1.0.4 - 2016-11-29

### Changed

- Added instructions to make mailcatching work with Laravel artisan commands (like queue workers).

## 1.0.3 - 2016-11-24

### Changed

- Add the dns option to the workspace image to fix dns issues on OSX.
- Add a better update section to the readme.
- Increased xdebug dumping depth to show everything when dumping data. (php-5.6-fpm image)
- Ensure all e-mail is caught by Mailhog by default and update the readme to reflect this change. (php-5.6-fpm image)

## 1.0.2 - 2016-11-21

### Added

- Wordpress multisite support in nginx image.
- mysql support (besides mysqli and pdo) in the php-5.6-fpm image.

## 1.0.1 - 2016-11-18

### Changed

- Allow file uploads up to 8MB in nginx image.

## 1.0.0 - 2016-11-11

### Added

- Mercurial added to workspace image.

### Changed

- Node.js to 6.* on workspace image.
- Readme.md tweaks.

## 0.8.1 - 2016-11-04

### Added

- Soap extension added to workspace and php-5.6-fpm images.

### Changed

- More items on the todo list.

## 0.8.0 - 2016-11-02

### Added

- Everything. This is the first public release. Yay.
