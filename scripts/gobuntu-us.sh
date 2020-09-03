#!/usr/bin/env bash
if docker inspect gobuntu-us >/dev/null 2>&1; then
  docker stop gobuntu-us 2>/dev/null
  docker rm gobuntu-us 2>/dev/null
fi

docker run -d \
	--name gobuntu-us \
	--hostname gobuntu-us \
	--restart unless-stopped \
	--memory "128M" \
	--cap-add=NET_ADMIN \
	--cap-add=NET_RAW \
	-e TZ=America/New_York \
	-p 2222:22 \
	-v gobuntu-us_data:/root \
	-v gobuntu-us_logs:/var/log \
	theniwo/gobuntu:latest

