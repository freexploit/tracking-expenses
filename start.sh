#!/bin/zsh


echo  "Starting new environment" |cowsay -f /usr/share/cows/dragon.cow
systemctl --user start podman.service
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"  
docker-compose up -d

