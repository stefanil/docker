# Docker's Help

## Important Steps using Docker

1. Build the Image

sudo docker build -t owncloudimage:7.0 .

2. Run container in interactive mode (bash to configure owncloud)

sudo docker run -i -t --rm owncloud:7.0 /bin/bash

3.1 Run the owncloud container using port forwarding (host > container) and keep it alive in foreground (using a bash)

sudo docker run -p 80:80 -i -t --rm owncloud:7.0 /bin/bash

3.2 Run the owncloud container using port forwarding (host > container) and keep it alive in background

sudo docker run -p 80:80 -d owncloud:7.0

Hint: Much better!!!

4. Persitente volumes hinzufügen

#sudo docker run -d -v data/mysql:/var/lib/mysql
sudo docker run -d -v data/owncloud/files:/var/www/owncloud/data
sudo docker run -d -v data/owncloud/config:/var/www/owncloud/config



## Further Commands:

### Show existing containers + port forwardings
sudo docker ps

### Show existing images
sudo docker images

### Kill all running containers
sudo docker kill $(sudo docker ps -q)

### Delete all stopped containers (including data-only containers)
sudo docker rm $(sudo docker ps -a -q)

### Delete all ‘untagged/dangling’ (<none>) images
sudo docker rmi $(sudo docker images -q -f dangling=true)

### Delete ALL images
sudo docker rmi $(sudo docker images -q)
