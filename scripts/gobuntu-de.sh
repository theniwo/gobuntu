#!/usr/bin/env bash
if docker inspect gobuntu >/dev/null 2>&1; then
  docker stop gobuntu 2>/dev/null
  docker rm gobuntu 2>/dev/null
fi

docker run -d \
	--name gobuntu \
	--hostname gobuntu-de \
	--restart unless-stopped \
	--memory "128M" \
	--cap-add=NET_ADMIN \
	--cap-add=NET_RAW \
	-e TZ=Europe/Berlin \
	-e LANG=de_DE.UTF-8 \
	-e LANGUAGE=de_DE.UTF-8 \
	-p 44287:22 \
	-v gobuntu_data:/root \
	-v gobuntu_logs:/var/log \
	theniwo/gobuntu:latest

