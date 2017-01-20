# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

- nothing

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
