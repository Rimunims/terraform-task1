 #!/bin/bash
 #install docker
 apt-get update
 apt-get install -y docker.io

 #Install Docekr compose
 curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname)" -o /usr/local/bin/docker-compose
 chmod +x /usr/local/bin/docker-compose

 # copying the docker file from metadata
 echo "${file("docker-compose.yml)}" > /home/docker-compose.yml

 #starting compose
 cd /home

 docker-compose up -d