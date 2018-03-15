# Docker Apache 2 on Ubuntu 17.10
Example of a Dockerfile with Apache 2 installed
VERSION 0.1

## DOCKER-VERSION 17.12.0-ce, build c97c6d6

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
docker run -it --name my_docker_apache -d -p 1337:80 {image_id}
```

{image_id} = the image_id from docker images command

6. Execute a docker container in bash shell:
```
docker exec -i -t my_docker_apache /bin/bash
```