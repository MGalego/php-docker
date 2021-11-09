# PHP development environment #

This [Docker Compose](https://docs.docker.com/compose) configuration enables a development environment for PHP 5.6, PHP 7 and Node projects.


## Installation

On Windows or Mac [install Docker Desktop][install-docker-desktop]

On Linux, [Install docker on your machine.][install-docker] and make sure you have the latest version of [docker-compose.][install-docker-compose]

### Windows settings

You must share your harddrive with Docker in order to let it to access the source code.

To achieve that you **must be running the docker with administrator right**, otherwise, you cannot apply the changes. So, open the Docker Settings by clicking on the icon on notify area of your toolbar and once there, on _Resources_ -> _FILE SHARING_ and you must mark the checkbox of your hard drive letter which you want to be shared with Docker.

Once you setup the sharing options, you must click on  _Apply and Restart_.

## Get it up and running

Clone this repository.

```bash
$ git clone https://github.com/MGalego/php-docker.git
```

Switch to the cloned directory.

```bash
$ cd php-docker
```

Edit docker-compose.yml and configure the path of the source code for each project.

```
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    container_name: mg_web
    volumes:
      - ../php7:/code/php7.local
      - ../php5:/code/php5.local
      - "./web/site.conf:/etc/nginx/conf.d/site.conf"
    depends_on:
      - php7    
      - php56
    networks:
      main:
        aliases:
          - php7.local             
```

Edit database configuration for each project. Set database host to "db".

Edit paths. Set difrutare paths with the prefix "/code/php5.local/".

Start the stack.

```bash
$ docker-compose up
```

## Database restore

In order to restore the databases execute the following commands in the console (in Windows use Powershell):

```bash
$ docker cp {name}.sql mg_db:/tmp/
$ docker exec -i mg_db sh -c '/usr/bin/mysql -u root --password=root {name} < /tmp/{name}.sql'
$ docker exec -i mg_db sh -c 'rm /tmp/*.sql'
```

## PHPStorm debug configuration

For each project:

1.  Open PHP server settings (File - Settings - Language and Frameworks - PHP - Servers
2.  Add a new server entry and fill with this information

![PHP server](/resources/php-server-config.png)

3.  Open Run - Edit configurations
4.  Add a new PHP Remote Debug entry and fill with this information

![Debug configuration](/resources/debug-config.png)


[install-docker-desktop]: https://www.docker.com/products/docker-desktop
[install-docker]: https://docs.docker.com/engine/installation
[install-docker-compose]: https://docs.docker.com/compose/install
