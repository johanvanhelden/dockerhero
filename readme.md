# Dockerhero
#### Version 0.8.1

### What is Dockerhero?
Dockerhero is a local development tool. Out of the box, it should only take a "docker-compose start" to get all your local PHP projects working. Yes, all of them. At the same time.

It has support for Laravel, Codeigniter, Wordpress and other PHP projects.

The goal is also to make it customizable. You can easily add your own nginx configurations, cronjobs and via phpMyAdmin you can create your own databases.

Dockerhero includes the following software (containers):
- nginx (latest)
- mySQL (5.6)
- PHP (5.6-fpm)
- Mailhog
- and more to come!

Dockerhero includes the following useful tools:
- phpMyAdmin
- Cron
- Mailhog
- Composer
- Xdebug
- NodeJS 4.*
- NPM
- Gulp
- Bower
- Vue-cli
- and more to come!

Localtest.me is used to make everything work without editing your hosts file! Just like magic!

### Installation
#### Docker and Docker Compose
Follow the instructions on the docker website to install [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/).

#### Folder placement
Next, it is essential to make sure dockerhero is inside the folder containing all the projects you wish to use with dockerhero. So if you want `https://mysuperproject.localtest.me` to be accessible, place and run dockerhero inside the same folder `mysuperproject` is located. For example, if the path to `mysuperproject` is: `/home/john/webdev/mysuperproject` - dockerhero needs to be located in `/home/john/webdev/dockerhero`.

This is because dockhero mounts its parent folder (`./../`) as `/var/www/projects/`, which is the location nginx will look for when it receives a request on `http://*.localtest.me`

*Remember: anything you do inside the container is deleted upon closing docker! Only changes to mounted folders (like your projects, databases) are persisted because those changes are actually done on your system.*

#### Trusting the self-signed certificate
Dockerhero has full support for https. This is done with a self-signed certificate. In order to skip the warning in your browser, you can trust the certificate by importing it in the browser or keychain. The certificate can be found [here](https://github.com/johanvanhelden/dockerhero-nginx/blob/master/.certs/localtest.me.crt).

This part is however entirely optional, and you do not have to do this. You can simply ignore the browser warning and continue.

### Usage
`$ cd` into the dockerhero folder on your local machine and execute:

    $ docker-compose up

This will give you real-time log information and usefull when debugging something. If anything fails, you can simply ctrl-c docker and it will shut down.

If you would rather prefer to run everything in the background, use:

    $ docker-compose start

And to stop the containers:

    $ docker-compose stop

### Databases
Via phpMyAdmin you can create new databases and users.
The database host you would need to use in your projects would be:

    mySQL host: dockerhero_db

You can visit phpMyAdmin by going to https://phpmyadmin.localtest.me

If you want to import databases from the file system, place them in `./databases/upload`.

Any exported databases to the file system can be found in `./databases/save`

### CLI Access
You can enter the bash environment of the containers by executing:

    docker exec -it --user=dockerhero dockerhero_workspace bash

All projects are available in `/var/www/projects/`

You can replace `dockerhero_workspace` with any container name.
The `--user=dockerhero` part is needed to prevent files from being generated with the root user and group. You will need to leave out this argument for other containers.

When you enter the bash environment, you will be starting in `/var/www/projects`

#### Protip! Make yourself a bash alias!
Make your life easier and create a function in your ~/.bash_aliases file like so:
```
sshDockerhero() {
    docker exec --user=dockerhero -it dockerhero_workspace bash
}
```

Now, in a new terminal, you can simply execute `sshDockerhero` and you will be inside the container.

### Custom nginx configs
You can place your own `*.conf` files into the `nginx/conf` folder. They will be automatically included once the container starts.

### Cronjobs
Create a new file in `./crons/` called `crons`. In this file, define all the cron lines you want. For an example, see the
`./crons/crons.sample` file.

### Mailhog
You can catch your application e-mail with the following e-mail settings:

    SMTP Host: dockerhero_mail
    SMTP Port: 1025

Next, visit the mailhog GUI by going to http://localhost:8025

### Contributing
Feel free to send in pull requests! Either to the image repos or the dockerhero repo itself. Do keep the following in mind:
- Everything needs to be as generic as possible, so do not try and add something that is super specific to your own use that no-one else will use.
- Everyone needs to be able to use it out of the box, without additional configuration. However, it is fine if a feature would be disabled without configuring. As long as users can still just clone the project and "go".
- If something needs documentation, add it to the readme.md.
- Test, test and test your changes.

### Thank you
- **localtest.me** - a big thank you goes out to localtest.me for providing a domain that points to 127.0.0.1. You can visit their website [here](http://readme.localtest.me/)
- **LaraDock** - also a huge shout out to LaraDock for providing me with a lot of sample code and inspiration. You can visit their GitHub page [here](https://github.com/LaraDock/laradock).

### Project links
- [Dockerhero - GitHub](https://github.com/johanvanhelden/dockerhero)
- [Dockerhero - Workspace GitHub](https://github.com/johanvanhelden/dockerhero-workspace)
- [Dockerhero - Nginx GitHub](https://github.com/johanvanhelden/dockerhero-nginx)
- [Dockerhero - PHP 5.6-fpm GitHub](https://github.com/johanvanhelden/dockerhero-php-5.6-fpm)

### Todo
- NodeJS to 6.* LTS
- Make a seperate php 7-fpm image to give users a choice
- Actually re-read the documentation and make sure everything is grammatically correct
- Make the timezone a setting that can be overwritten when starting containers
- Figure out why mysql sometimes does not persist
- Set up a GitHub page
