# Dockerhero

## Version 2.2.0

### What is Dockerhero?

Dockerhero is a local development tool. Out of the box, it should only take a "docker-compose start" to get **all your local PHP projects working**. Yes, all of them. **At the same time**.

It has support for Laravel, Codeigniter, Wordpress and other PHP projects.
It has dynamic docroot support for both `public` and `public_html`, depending on what folder is found in your project. **Zero setup needed!**

The goal is also to make it customizable. You can easily add your own nginx configurations, cronjobs and via phpMyAdmin you can create your own databases.

Dockerhero includes the following software (containers):

- nginx (latest)
- mySQL (5.7)
- Redis (latest)
- PHP (7.4-fpm by default, [or choose a different version](#picking-a-php-version))
- Mailhog
- and more to come!

Dockerhero includes the following useful tools:

- phpMyAdmin
- phpRedisAdmin
- Cron
- Mailhog
- Composer
- Xdebug (with remote debugging support)
- NVM (pre-installed with node 10, 12 and 14 and the default version is 14)
- NPM
- Yarn
- Vue-cli
- Laravel Artisan autocompletion
- Laravel Dusk support
- laravel-dump-server support
- OCI8 support
- and more to come!

Localtest.me is used to make everything work without editing your hosts file! Just like magic!

## Table of Contents

1. [Installation](#installation)
    1. [Docker and Docker Compose](#docker-and-docker-compose)
    2. [Folder placement](#folder-placement)
    3. [Picking a PHP version](#picking-a-php-version)
    4. [Trusting the self-signed certificate](#trusting-the-self-signed-certificate)
    5. [WSL2](#wsl2)
2. [Updating](#updating)
    1. [Dockerhero itself](#dockerhero-itself)
    2. [Dockerhero images](#dockerhero-images)
3. [Usage](#usage)
    1. [Starting](#starting)
    2. [Stopping](#stopping)
    3. [Private composer packages](#private-composer-packages)
4. [Databases](#databases)
    1. [MySQL](#mysql)
        1. [Using MySQL with Laravel](#using-mysql-with-laravel)
        2. [Changing the MySQL version](#changing-the-mysql-version)
        3. [Upgrading MySQL](#upgrading-mysql)
        4. [Changing the SQL mode](#changing-the-sql-mode)
    2. [Redis](#redis)
        1. [Using Redis with Laravel](#using-redis-with-laravel)
5. [CLI Access](#cli-access)
6. [Custom nginx configs](#custom-nginx-configs)
7. [Cronjobs](#cronjobs)
8. [Mailhog](#mailhog)
9. [Overriding default settings](#overriding-default-settings)
10. [Connecting from PHP to a local project via URL](#connecting-from-php-to-a-local-project-via-url)
11. [Making a local website publicly available](#making-a-local-website-publicly-available)
12. [Connecting to a docker container from your host](#connecting-to-a-docker-container-from-your-host)
13. [Miscellaneous](#miscellaneous)
    1. [Laravel Dusk](#laravel-dusk)
    2. [laravel-dump-server](#laravel-dump-server)
    3. [Remote Xdebug](#remote-xdebug)
        1. [Starting Xdebug](#starting-xdebug)
        2. [Configuring the IDE](#configuring-the-ide)
14. [Known issues](#known-issues)
    1. [MacOS](#macos)
15. [Contributing](#contributing)
    1. [Testing changes](#testing-changes)
16. [Thank you](#thank-you)
17. [Project links](#project-links)
18. [Todo](#todo)

## Installation

### Docker and Docker Compose

Follow the instructions on the docker website to install [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/).

### Folder placement

Next, it is essential to make sure Dockerhero is inside the folder containing all the projects you wish to use with Dockerhero. So if you want `https://mysuperproject.localtest.me` to be accessible, place and run Dockerhero inside the same folder `mysuperproject` is located. For example, if the path to `mysuperproject` is: `/home/john/webdev/mysuperproject` - Dockerhero needs to be located in `/home/john/webdev/dockerhero`.

This is because dockhero mounts its parent folder (`./../`) as `/var/www/projects/`, which is the location nginx will look for when it receives a request on `http://*.localtest.me`

_Remember: anything you do inside the container is deleted upon closing docker! Only changes to mounted folders (like your projects, databases) are persisted because those changes are actually done on your system._

### Picking a PHP version
By default, PHP 7.4 is active. If you would like to change this to another version, you can do so by overriding the option using the `docker-compose.override.yml` to change image. For example, if you want to use PHP 8.0, it might look like this:

```yml
version: "2"

services:
  workspace:
    image: johanvanhelden/dockerhero-workspace:php8.0
  php:
    image: johanvanhelden/dockerhero-php-8.0-fpm:latest
```

For more information, please see this section: [Overriding default settings](#overriding-default-settings)

#### Available PHP Images:

PHP 8.0: `johanvanhelden/dockerhero-php-8.0-fpm:latest`

PHP 7.4: `johanvanhelden/dockerhero-php-7.4-fpm:latest`

PHP 7.3: `johanvanhelden/dockerhero-php-7.3-fpm:latest`

PHP 7.2: `johanvanhelden/dockerhero-php-7.2-fpm:latest`

PHP 7.1: `johanvanhelden/dockerhero-php-7.1-fpm:latest` (No longer maintained)

PHP 5.6: `johanvanhelden/dockerhero-php-5.6-fpm:latest` (No longer maintained)

PHP 5.4: `johanvanhelden/dockerhero-php-5.4-fpm:latest` (No longer maintained)

#### Workspace images
You should pick a matching workspace image for the PHP version you are using.

PHP 8.0: `johanvanhelden/dockerhero-workspace:php8.0`

PHP 7.4: `johanvanhelden/dockerhero-workspace:php7.4`

PHP 7.3: `johanvanhelden/dockerhero-workspace:php7.3`

PHP 7.2: `johanvanhelden/dockerhero-workspace:php7.2`

PHP 7.1: `johanvanhelden/dockerhero-workspace:php7.1` (No longer maintained)

There is also a latest tag, this one is used to remain backward compatible, but should not be actively used.

### Trusting the self-signed certificate

Dockerhero has full support for https. This is done with a self-signed certificate. In order to skip the warning in your browser, you can trust the certificate by importing it in the browser or keychain. The certificate can be found [here](https://github.com/johanvanhelden/dockerhero-nginx/blob/master/.certs/localtest.me.crt).

This part is however entirely optional, and you do not have to do this. You can simply ignore the browser warning and continue.

### WSL2

Dockerhero works great with WSL2 but requires one additional setup step if you want to execute, for example, artisan commands or PHPUnit tests from outside Dockerhero.
Simply add `dns: 0.0.0.0` to all of the containers in your `docker-compose.override.yml` (if you do not have one,
[please create it](#overriding-default-settings)) like so:

```yml
  workspace:
    dns: 0.0.0.0
  php:
    dns: 0.0.0.0
  web:
    dns: 0.0.0.0
  db:
    dns: 0.0.0.0
  mail:
    dns: 0.0.0.0
  redis:
    dns: 0.0.0.0
```

## Updating

### Dockerhero itself

Simply download or pull the latest release from [GitHub](https://github.com/johanvanhelden/dockerhero) and [update the images](#dockerhero-images).

### Dockerhero images

To ensure you have the latest images, you can run `docker-compose pull` in the Dockerhero folder.

## Usage
### Starting
`$ cd` into the Dockerhero folder on your local machine and execute:

```bash
docker-compose up
```

This will give you real-time log information and useful when debugging something. If anything fails, you can simply `ctrl-c` docker and it will shut down.

If you would rather prefer to run everything in the background, use:

```bash
docker-compose start
```

### Stopping

To stop the containers, simple stop the `docker-compose up` process using `ctrl-c`.

If you had it running in the background, you can use:

```bash
docker-compose stop
```

### Private composer packages
If you need to access private composer packages, you might want to link your local `/home/username/.composer` folder (containing your auth.json file) and `/home/username/.ssh` folder (containing any SSH keys necessary to clone packages) to Dockerhero. You can do so by adding a new volume to the workspace image in your `docker-compose.override.yml` (if you do not have one,
[please create it](#overriding-default-settings)) like so:

```yml
version: '2'

services:
  workspace:
    volumes:
      - /home/username/.composer:/home/dockerhero/.composer
      - /home/username/.ssh:/home/dockerhero/.ssh
```

You will now be able to install and update private packages inside Dockerhero.

## Databases

### MySQL

Via phpMyAdmin you can create new databases and users. The database host you would need to use in your projects would be:

```
mySQL host: dockerhero_db
mySQL port: 3306
```

You can visit phpMyAdmin by going to `https://phpmyadmin.localtest.me`

If you want to import databases from the file system, place them in `./databases/upload`.

Any exported databases to the file system can be found in `./databases/save`

#### Using MySQL with Laravel

This is what a working configuration would look like:

```
DB_CONNECTION=mysql
DB_HOST=dockerhero_db
DB_PORT=3306
DB_DATABASE=my_project_db
DB_USERNAME=my_project
DB_PASSWORD=my_project
```

This assumes you created the proper database and user with the password using, for example, PHPMyAdmin.

#### Changing the MySQL version
If you would like to change the MySQL version, you can do so by editing the `docker-compose.override.yml` (if you do not
have one, [please create it](#overriding-default-settings)) like so:
```yml
version: '2'

services:
  db:
    image: mysql:5.6
```

#### Upgrading MySQL
If you changed the MySQL image to a newer version, it will be necessary to upgrade your current databases.
You can do so by logging into the database container and running the `mysql_upgrade` command, like so:
`docker exec -it dockerhero_db bash`

Once inside the database container you need to run the following command:
`mysql_upgrade -u root -pdockerhero`

After the upgrade is done, please restart Dockerhero.

#### Changing the SQL mode
By default, I've set the same SQL mode as MySQL 5.6 to ensure maximum backwards compatibility. If you would like to
set it to the 5.7 default setting, you can do so by editing the `docker-compose.override.yml` (if you do not have one,
[please create it](#overriding-default-settings)) like so:
```yml
version: '2'

services:
  db:
    command: --sql_mode="ONLY_FULL_GROUP_BY"
```

### Redis

In order to use Redis in your projects, you need to define the following host:

```
Redis host: dockerhero_redis
Redis port: 6379
```

You can visit phpRedisAdmin by going to `https://phpredisadmin.localtest.me`

#### Using Redis with Laravel

This is what a working configuration would look like:

```

CACHE_DRIVER=redis

-- snip --

QUEUE_CONNECTION=redis

-- snip --

SESSION_DRIVER=redis

-- snip --

REDIS_HOST=dockerhero_redis
REDIS_PASSWORD=null
REDIS_PORT=6379
```

## CLI Access

You can enter the bash environment of the containers by executing:

```bash
docker exec -it --user=dockerhero dockerhero_workspace bash
```

All projects are available in `/var/www/projects/`

You can replace `dockerhero_workspace` with any container name. The `--user=dockerhero` part is needed to prevent files from being generated with the root user and group. You will need to leave out this argument for other containers.

When you enter the bash environment, you will be starting in `/var/www/projects`

### Artisan autocompletion

If you are inside a Laravel folder, you can type `artisan` (instead of `./artisan` or `php artisan`) and tab to autocomplete.

### Protip! Make yourself a bash alias!

Make your life easier and create a function in your ~/.bash_aliases file like so:

```bash
sshDockerhero() {
  docker exec --user=dockerhero -it dockerhero_workspace bash
}
```

Now, in a new terminal, you can simply execute `sshDockerhero` and you will be inside the container.

## Custom nginx configs

You can place your own `*.conf` files into the `nginx/conf` folder. They will be automatically included once the container starts.

## Cronjobs

Create a new file in `./crons/` called `crons`. In this file, define all the cron lines you want. For an example, see the `./crons/crons.sample` file.

## Mailhog

All outgoing mail is caught by default. You do not need to configure anything. To view the e-mail that has been send, visit the [Mailhog GUI](http://localhost:8025)

For some reason, this autocatching does not work properly with Laravel artisan commands (like queue workers). In order to make it work, you can set the .env settings like so:

```
MAIL_DRIVER=smtp
MAIL_HOST=dockerhero_mail
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
```

## Overriding default settings
You can create a brand new `docker-compose.override.yml` in the root of Dockerhero to override default settings or customize things.
It might look a bit like this:

```yml
version: '2'

services:
  php:
    extra_hosts:
      - "projectname.localtest.me:172.25.0.12"
  workspace:
    extra_hosts:
      - "projectname.localtest.me:172.25.0.12"
```

## Connecting from PHP to a local project via URL

Add the following entry to the `docker-compose.override.yml` file in the `php:` section:

```yml
extra_hosts:
  - "projectname.localtest.me:172.25.0.12"
```

Where 172.25.0.12 is the IP of the dockerhero_web container.

Now, if PHP attempts to connect to projectname.localtest.me, it will not connect to his localhost, but to the nginx container.

## Making a local website publicly available

If you are developing for an API, webhook or if you want to demonstrate something to someone, it can be extremely useful to forward your local website to the public internet.

In order to do this:

- Download ngrok from: <https://ngrok.com/>
- Extract the zip file
- Run the following command from the command line:

```bash
./ngrok http 127.0.0.1:80 -host-header=project.localtest.me
```

Where the host-header flag contains the URL of the project you would like to forward.

Ngrok will now present you with a unique ngrok URL. This is the URL you can give out to clients or use in the API/webhook settings.

## Connecting to a docker container from your host

If you want to connect to a docker container from your host, for example to connect to the `dockerhero_db` container using a local MySQL application, you can add all the docker containers to your host file. Simply paste the following container -> ip mapping (the IPs are hardcoded and should never change):

```
172.25.0.12 dockerhero_web
172.25.0.11 dockerhero_php
172.25.0.13 dockerhero_db
172.25.0.10 dockerhero_workspace
172.25.0.15 dockerhero_redis
172.25.0.14 dockerhero_mail
```

Now, on your host, `dockerhero_db` should also point to the database container.

Pro-tip: so it's also possible now to execute a test suite on your host system using the same environment file. Because your host now knows how to resolve all the container names.

## Miscellaneous

### Laravel Dusk

In order to make Laravel Dusk work, you need to add your Laravel project URL to the "extra_hosts" section of the docker compose workspace section, as explained in the "[Connecting from PHP to a local project via URL](#connecting-from-php-to-a-local-project-via-url)" section.

### laravel-dump-server

[laravel-dump-server](https://github.com/beyondcode/laravel-dump-server) is a great package that allows you to capture dump contents so that it does not interfere with HTTP / API responses.

In order to make it work with dockerhero, simply override the config and point it to the workspace container, like so:
```php
'host' => 'tcp://dockerhero_workspace:9912',
```

Next, ssh into to workspace image, and simply run: `$ artisan dump-server` and start dumping to your heart's content.

### Remote Xdebug

#### Starting Xdebug
Xdebug is disabled per default to speed up PHP. If you want to start remote debugging, you would have to enable Xdebug first. To do this, execute the `xdebug/start.sh` script in the scripts folder.
This enables Xdebug in the PHP and Workspace container.

Make your life easier and create these functions in your ~/.bash_aliases file like so:

```bash
xdebugStatus() {
    $projectPath/dockerhero/scripts/xdebug/status.sh
}

xdebugStop() {
    $projectPath/dockerhero/scripts/xdebug/stop.sh
}

xdebugStart() {
    $projectPath/dockerhero/scripts/xdebug/start.sh
}
```

Now you can simply run `$ xdebugStart` and `$ xdebugStop`.


#### Configuring the IDE
It is possible to remotely debug your code using an IDE.
You would have to set up your IDE to use port *9005*.
And you would have to properly map your local path to Dockerhero (the project root is always `/var/www/projects` in Dockerhero).

This is a working config for VSCode for a Laravel project (but has also been tested for CodeIgniter projects):
```json
{
    "name": "Listen for XDebug",
    "type": "php",
    "request": "launch",
    "port": 9005,
    "pathMappings": {
        "/var/www/projects/${workspaceFolderBasename}": "${workspaceFolder}"
    },
    "ignore": [
        "**/vendor/**/*.php"
    ]
},
```

## Known issues

### MacOS
On MacOS there is an issue with linking the timezone. I do now own a Mac myself, so I am unable to produce a proper solution, but for now, I suggest you timezone links from the `volumes:` section for each container (`workspace`, `php`, `web`, `db`) that links the time-zones. If you are someone who owns a Mac, please let me know how I can properly address this, if you can.

## Contributing

Feel free to send in pull requests! Either to the image repos or the Dockerhero repo itself. Do keep the following in mind:

- Everything needs to be as generic as possible, so do not try and add something that is super specific to your own use that no-one else will use.
- Everyone needs to be able to use it out of the box, without additional configuration. However, it is fine if a feature would be disabled without configuring. As long as users can still just clone the project and "go".
- If something needs documentation, add it to the readme.md.
- Test, test and test your changes before you create the PR.
- Always target your PR's to the `develop` branche.

### Testing changes
To test changes to Dockerhero images, you can either follow the instructions from the README of the images or, if you want to test those changes in the Dockerhero system itself, you add the overwrite to the `docker-compose.override.yml` for the container you want to test. For example:
```yml
version: '2'

services:
  php:
    build: ../dockerhero-php-7.3-fpm
```

Next, start Dockerhero using the following command: `docker-compose up --build`.

Once everything is tested and works properly, you can revert the changes to the `docker-compose.yml` and create the PR.

Don't forget to stop and start Dockerhero again after reverting the `docker-compose.yml` file, otherwise you keep using the local forked image. For the first time, after reverting the changes, I recommend to use `docker-compose up --build --no-cache` to ensure everything is fresh again.

## Thank you

- **localtest.me** - a big thank you goes out to localtest.me for providing a domain that points to 127.0.0.1\. You can visit their website [here](http://readme.localtest.me/)
- **LaraDock** - also a huge shout out to LaraDock for providing me with a lot of sample code and inspiration. You can visit their GitHub page [here](https://github.com/LaraDock/laradock).

## Project links

- [Dockerhero - GitHub](https://github.com/johanvanhelden/dockerhero)
- [Dockerhero - Workspace GitHub](https://github.com/johanvanhelden/dockerhero-workspace)
- [Dockerhero - Nginx GitHub](https://github.com/johanvanhelden/dockerhero-nginx)
- [Dockerhero - PHP 8.0-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-8.0-fpm)
- [Dockerhero - PHP 7.4-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-7.4-fpm)
- [Dockerhero - PHP 7.3-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-7.3-fpm)
- [Dockerhero - PHP 7.2-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-7.2-fpm)
- [Dockerhero - PHP 7.1-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-7.1-fpm)
- [Dockerhero - PHP 5.6-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-5.6-fpm)
- [Dockerhero - PHP 5.4-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-5.4-fpm)

## Todo

- Make the timezone a setting that can be overwritten when starting containers
- Set up a GitHub page
- Add badges to the other repos
- PR hooks for automated builds to ensure everything passes
- Automate testing of Dockerhero itself
