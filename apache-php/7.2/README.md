# Docker Apache 2 AND PHP 7.2 on Ubuntu 17.10
Example of a Dockerfile with Apache 2 installed
VERSION 0.1

## DOCKER-VERSION 17.12.0-ce, build c97c6d6

### Apache environment variables
Apache will make of the following environment variables.

	APACHE_SERVERADMIN=admin@localhost
	APACHE_SERVERNAME=localhost
	APACHE_SERVERALIAS=docker.localhost
	APACHE_DOCUMENTROOT=/var/www
	APACHE_RUN_USER=www-data
	APACHE_RUN_GROUP=www-data
	APACHE_LOG_DIR=/var/web/log/apache2
	APACHE_PID_FILE=/var/run/apache2.pid
	APACHE_RUN_DIR=/var/run/apache2
	APACHE_LOCK_DIR=/var/lock/apache2

To build:
1. Install docker (http://docker.io)
2. Checkout source: 
```
git clone https://github.com/iam-dev/Docker.git
```
3. Build container: 
```
cd Docker
cd apache
docker build -t docker_apache:0.1 .
```
4. Check docker images: 
```
docker images
```
5. Docker run:
```
docker run -i -d -p 1337:80 -e APACHE_SERVERNAME=iamdeveloper.io  {image_id}
```

{image_id} = the image_id from docker images command

6. Execute a docker container in bash shell:
```
docker exec -i -t my_docker_apache /bin/bash
```