# Dockerhero

## Version 1.1.5

### What is Dockerhero?

Dockerhero is a local development tool. Out of the box, it should only take a "docker-compose start" to get all your local PHP projects working. Yes, all of them. At the same time.

It has support for Laravel, Codeigniter, Wordpress and other PHP projects.

The goal is also to make it customizable. You can easily add your own nginx configurations, cronjobs and via phpMyAdmin you can create your own databases.

Dockerhero includes the following software (containers):

- nginx (latest)
- mySQL (5.6)
- Redis (latest)
- PHP (5.6-fpm or 7.1-fpm)
- Mailhog
- and more to come!

Dockerhero includes the following useful tools:

- phpMyAdmin
- phpRedisAdmin
- Cron
- Mailhog
- Composer
- Xdebug
- Node.js 6.*
- NPM
- Yarn
- Gulp
- Bower
- Vue-cli
- Laravel Artisan autocompletion
- Laravel Dusk support
- and more to come!

Localtest.me is used to make everything work without editing your hosts file! Just like magic!

## Table of Contents

1. [Installation](#installation)
2. [Updating](#updating)
3. [Usage](#usage)
4. [Databases](#databases)
5. [CLI Access](#cli-access)
6. [Custom nginx configs](#custom-nginx-configs)
7. [Cronjobs](#cronjobs)
8. [Mailhog](#mailhog)
9. [Overriding default settings](#overriding-default-settings)
10. [Connecting from PHP to a local project via URL](#connecting-from-php-to-a-local-project-via-url)
11. [Making a local website publicly available](#making-a-local-website-publicly-available)
12. [Using Laravel Dusk](#using-laravel-dusk)
13. [Contributing](#contributing)
14. [Thank you](#thank-you)
15. [Project links](#project-links)
16. [Todo](#todo)

## Installation

### Docker and Docker Compose

Follow the instructions on the docker website to install [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/).

### Folder placement

Next, it is essential to make sure dockerhero is inside the folder containing all the projects you wish to use with dockerhero. So if you want `https://mysuperproject.localtest.me` to be accessible, place and run dockerhero inside the same folder `mysuperproject` is located. For example, if the path to `mysuperproject` is: `/home/john/webdev/mysuperproject` - dockerhero needs to be located in `/home/john/webdev/dockerhero`.

This is because dockhero mounts its parent folder (`./../`) as `/var/www/projects/`, which is the location nginx will look for when it receives a request on `http://*.localtest.me`

_Remember: anything you do inside the container is deleted upon closing docker! Only changes to mounted folders (like your projects, databases) are persisted because those changes are actually done on your system._

### Picking a PHP version
By default, PHP 5.6 is active. If you would like to change this to PHP 7.1, you can do so by overriding the option using the docker-compose.override.yml to change image.

For more information, please see this section: [Overriding default settings](#overriding-default-settings)

The PHP 5.6 image is: `johanvanhelden/dockerhero-php-5.6-fpm:latest`

The PHP 7.1 image is: `johanvanhelden/dockerhero-php-7.1-fpm:latest`

### Trusting the self-signed certificate

Dockerhero has full support for https. This is done with a self-signed certificate. In order to skip the warning in your browser, you can trust the certificate by importing it in the browser or keychain. The certificate can be found [here](https://github.com/johanvanhelden/dockerhero-nginx/blob/master/.certs/localtest.me.crt).

This part is however entirely optional, and you do not have to do this. You can simply ignore the browser warning and continue.

## Updating

Simply download or pull the latest release from [GitHub](https://github.com/johanvanhelden/dockerhero) and [update the images](#updating-images).

### Updating images

To ensure you have the latest images, you can run `docker-compose pull` in the dockerhero folder.

## Usage
### Starting
`$ cd` into the dockerhero folder on your local machine and execute:

```
$ docker-compose up
```

This will give you real-time log information and useful when debugging something. If anything fails, you can simply ctrl-c docker and it will shut down.

If you would rather prefer to run everything in the background, use:

```
$ docker-compose start
```

And to stop the containers:

```
$ docker-compose stop
```

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

### Redis

In order to use Redis in your projects, you need to define the following host:

```
Redis host: dockerhero_redis
Redis port: 6379
```

You can visit phpRedisAdmin by going to `https://phpredisadmin.localtest.me`

## CLI Access

You can enter the bash environment of the containers by executing:

```
docker exec -it --user=dockerhero dockerhero_workspace bash
```

All projects are available in `/var/www/projects/`

You can replace `dockerhero_workspace` with any container name. The `--user=dockerhero` part is needed to prevent files from being generated with the root user and group. You will need to leave out this argument for other containers.

When you enter the bash environment, you will be starting in `/var/www/projects`

### Artisan autocompletion

If you are inside a Laravel folder, you can type `artisan` (instead of `./artisan` or `php artisan`) and tab to autocomplete.

### Protip! Make yourself a bash alias!

Make your life easier and create a function in your ~/.bash_aliases file like so:

```
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
You can create a brand new docker-compose.override.yml in the root of dockerhero to override default settings or customize things.
It might look a bit like this:

```
version: '2'

services:
  php:
    image: johanvanhelden/dockerhero-php-7.1-fpm:latest
    extra_hosts:
      - "projectname.localtest.me:172.18.0.6"
  workspace:
    extra_hosts:
      - "projectname.localtest.me:172.18.0.6"
```

## Connecting from PHP to a local project via URL

Add the following entry to the docker-compose.override.yml file in the `php:` section:

```
extra_hosts:
  - "projectname.localtest.me:172.18.0.6"
```
Where 172.18.0.6 is the IP of the dockerhero_web container. To find the IP address you could use:

`$ docker inspect dockerhero_web | grep IPAddress`

Now, if PHP attempts to connect to projectname.localtest.me, it will not connect to his localhost, but to the nginx container.

## Making a local website publicly available

If you are developing for an API, webhook or if you want to demonstrate something to someone, it can be extremely useful to forward your local website to the public internet.

In order to do this:

- Download ngrok from: <https://ngrok.com/>
- Extract the zip file
- Run the following command from the command line:

`$ ./ngrok http 127.0.0.1:80 -host-header=project.localtest.me`

Where the host-header flag contains the URL of the project you would like to forward.

Ngrok will now present you with a unique ngrok URL. This is the URL you can give out to clients or use in the API/webhook settings.

## Using Laravel Dusk

In order to make Laravel Dusk work, you need to add your Laravel project URL to the "extra_hosts" section of the docker compose workspace section, as explained in the "[Connecting from PHP to a local project via URL](#connecting-from-php-to-a-local-project-via-url)" section.

## Contributing

Feel free to send in pull requests! Either to the image repos or the dockerhero repo itself. Do keep the following in mind:

- Everything needs to be as generic as possible, so do not try and add something that is super specific to your own use that no-one else will use.
- Everyone needs to be able to use it out of the box, without additional configuration. However, it is fine if a feature would be disabled without configuring. As long as users can still just clone the project and "go".
- If something needs documentation, add it to the readme.md.
- Test, test and test your changes.

## Thank you

- **localtest.me** - a big thank you goes out to localtest.me for providing a domain that points to 127.0.0.1\. You can visit their website [here](http://readme.localtest.me/)
- **LaraDock** - also a huge shout out to LaraDock for providing me with a lot of sample code and inspiration. You can visit their GitHub page [here](https://github.com/LaraDock/laradock).

## Project links

- [Dockerhero - GitHub](https://github.com/johanvanhelden/dockerhero)
- [Dockerhero - Workspace GitHub](https://github.com/johanvanhelden/dockerhero-workspace)
- [Dockerhero - Nginx GitHub](https://github.com/johanvanhelden/dockerhero-nginx)
- [Dockerhero - PHP 5.6-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-5.6-fpm)
- [Dockerhero - PHP 7.1-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-7.1-fpm)

## Todo

- Make a seperate php 7-fpm image to give users a choice
- Make the timezone a setting that can be overwritten when starting containers
- Set up a GitHub page
