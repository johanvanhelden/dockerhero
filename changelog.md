# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## 3.3.0 - 2022-02-18 [Unreleased]

- [Workspace] Make Node 16 the new default version
- [Workspace] Remove Node 10
- [Workspace] Add Node 16 and 17
- [Workspace] Add pcov extension
- Fix docker-compose v3 issues
- Update PHPMyAdmin to 5.1.1 for PHP 8.1 compatibility

## 3.2.0 - 2021-12-03

- Add PHP 8.1
- Make PHP 8.1 the default version

## 3.1.0 - 2021-07-16

- Update PHP 8.0 images
- Make PHP 8.0 the default version

## 3.0.2 - 2021-06-21

- Fixes an issue with the self-signed certificate (`docker-compose pull` && `docker-compose up` and trust the [new certificate](https://github.com/johanvanhelden/dockerhero-nginx/blob/master/.certs/localtest.crt) to apply the fix)

## 3.0.1 - 2021-06-15

- Removed the MYSQL_USER db container environment variables as this conflicts with newer docker versions

## 3.0.0 - 2021-04-15

- Update Composer to support the new GitHub personal token format
- Drop OCI8 support (I can no longer maintain this by myself)
- Drop support for PHP 7.2 (EOL)

## 2.2.0 - 2021-04-13

- Switch to version `3` of the docker-compose file
- Added WSL2 section to the readme
- Added health checks for Redis and MySQL
- Remove DNS from mail en db containers
- Expose the `3306` MySQL port by default
- Update PHPMyAdmin to 5.1.0
- Fix CVE-2021-30130 in PHPMyAdmin

## 2.1.1 - 2021-01-18

## Added
- [Global] PHP 8.0 added

## 2.1.0 - 2020-11-25

## Added
- [Workspace] Added node 12 and 14, make 14 the default

## Removed
- [Workspace] Deprecated Gulp

### Changed

- [Gobal] Update PHPMyAdmin to 5.0.4
- [Workspace] Update Composer to v2

## 2.0.0 - 2020-08-10

### Added

- [Gobal] Make container IPs static
- [Gobal] Add more examples to the readme

## 1.8.0 - 2020-07-30

### Added

- [Gobal] Make 7.4 the default PHP version

## 1.7.2 - 2020-06-11

### Added

- [Workspace] Added the imagick extension
- [PHP] Added the imagick extension

## 1.7.1 - 2020-05-07

### Added

- [Gobal] Fixed the Xdebug start and stop scripts

## 1.7.0 - 2020-04-28

### Added

- [Workspace] Updated composer on all supported PHP versions
- [Workspace] Intl extension added to all supported PHP versions to be consistent with the PHP images
- [Gobal] PHP 7.4 added

## 1.6.1 - 2020-02-04

### Changed

- [Workspace] Rebuild the supported tags to update composer to 1.9.3.

## 1.6.0 - 2020-01-18

### Added

- [Global] PHP 7.3 is now the default version
- [Workspace] The image is now tagged with the PHP version to properly allow for complete PHP version switching
- [Workspace] Depricated `bower` and switched `vue-cli` to `@vue/cli`
- [Workspace] Node 10 is now the default version

## 1.5.3 - 2020-01-09

### Added

- OCI8 and PDO_OCI to the PHP 7.2, 7.3 and workspace images.

## 1.5.2 - 2019-10-15

### Changed

- PHPMyAdmin version downgraded to 4.9.1, due to broken upload / save to and from the filesystem in 5.0.0-alpha1. If you have any issues, please clear you browser cache!

### Added

- PHPMyAdmin `databases/save` and `databases/upload` support has been added again.

## 1.5.1 - 2019-09-28

### Added

- `public` folder support (both `public_html` AND `public` will work now, depending on what folder is found in your project).

## 1.5.0 - 2019-09-28

### Added

- Xdebug start, stop and status scripts to easily turn Xdebug on, off or request the status.

### Changed

- Disabled Xdebug per default in the PHP 7.2, 7.3 and workspace images to speed up PHP.

## 1.4.3 - 2019-08-20

### Added

- Exif extension to PHP 7.2 and PHP 7.3 image to by consistent with the workspace image.

## 1.4.2 - 2019-08-09

### Added

- Remote XDebug capabilities in the PHP 7.2 and php 7.3 images and instructions to the readme.

### Changed

- Replaced mysql-client with mariadb-client in PHP 7.2 and PHP 7.3 images due to deprication if the mysql-client package.
- Replaced ssmtp with mhsendmail in PHP 7.2 and PHP 7.3 images due to deprication if the ssmtp package.
- Updated phpMyAdmin to 5.0.0-alpha1

## 1.4.1 - 2019-05-21

### Changed

- Added Xdebug to the workspace container - @pkeulers

## 1.4.0 - 2019-05-14

This is a pretty major release that sets PHP 7.2 as the default version for both the PHP and the Workspace container.
If you are not ready yet for this change, you can roll back to PHP 7.1 by adding a `docker-compose.override.yml` with
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
- Switched to a development version of phpMyAdmin (5.0.0-dev) to have an upgraded jQuery version (CVE-2019-11358)

## 1.3.2 - 2019-01-07

### Changed

- Updated phpMyAdmin version to 4.8.4

### Added

- PHP 7.3 image

## 1.3.1 - 2018-09-04

### Changed

- Increased the default upload size from 8m to 64m in the nginx image

## 1.3.0 - 2018-09-04

### Changed

- The default MySQL version is now 5.7

### Added

- Added sections to the readme on how to change the MySQL version and SQL mode
- Added a known issues section to the readme with a known MacOS issue

## 1.2.6 - 2018-07-17

### Changed

- Node 8 is now the default version in the workspace image

### Added

- bcmath extension to the workspace, php 7.1 and php 7.2 image

## 1.2.5 - 2018-07-16

### Changed

- Expose the default laravel-dump-server port for the PHP image
- Expand the readme's ToC and restructure it

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

- Made PHP 7.1 the default version
- Rebuild workspace and PHP 7.1 images (updated PHP 7.1 to 7.1.12 and Yarn to 1.3.2)

## 1.1.5 - 2017-05-01

### Added

- A PHP 7.1 container option

## 1.1.4 - 2017-03-21

### Added

- Redis PHP extension (php and workspace image) - @pkeulers
- Proper sendmail path to mailhog in php.ini (php image) - this will allow crons to send mail as well
- phpRedisAdmin (<http://phpredisadmin.localtest.me>)

## 1.1.3 - 2017-03-04

### Added

- A redis container
- Instructions on how to make a local website publicly available using ngrok

## 1.1.2 - 2017-02-10

### Added

- Chrome in order to support Laravel Dusk. (workspace image)
- A using Laravel Dusk section to the readme

### Changed

- Ignore docker-compose.override.yml file - in order to make it easy to make changes to settings
- No longer force SSL. (nginx image)
- Better explanation on how to connect to projects from within containers in the readme

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
- Section to the readme on how to forward requests to nginx container from PHP

## 1.0.5 - 2016-12-05

### Added

- Laravel Artisan autocompletion. (workspace image)

## 1.0.4 - 2016-11-29

### Changed

- Added instructions to make mailcatching work with Laravel artisan commands (like queue workers)

## 1.0.3 - 2016-11-24

### Changed

- Add the dns option to the workspace image to fix dns issues on OSX
- Add a better update section to the readme
- Increased xdebug dumping depth to show everything when dumping data. (php-5.6-fpm image)
- Ensure all e-mail is caught by Mailhog by default and update the readme to reflect this change. (php-5.6-fpm image)

## 1.0.2 - 2016-11-21

### Added

- Wordpress multisite support in nginx image
- mysql support (besides mysqli and pdo) in the php-5.6-fpm image

## 1.0.1 - 2016-11-18

### Changed

- Allow file uploads up to 8MB in nginx image

## 1.0.0 - 2016-11-11

### Added

- Mercurial added to workspace image

### Changed

- Node.js to 6.* on workspace image
- Readme.md tweaks

## 0.8.1 - 2016-11-04

### Added

- Soap extension added to workspace and php-5.6-fpm images

### Changed

- More items on the todo list

## 0.8.0 - 2016-11-02

### Added

- Everything. This is the first public release. Yay.
