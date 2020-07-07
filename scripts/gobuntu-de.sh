<<<<<<< HEAD:scripts/gobuntu-de.sh
if docker inspect gobuntu-de >/dev/null 2>&1; then
  docker stop gobuntu-de 2>/dev/null
  docker rm gobuntu-de 2>/dev/null
fi

docker run -d \
	--name gobuntu-de \
=======
if docker inspect gobuntu >/dev/null 2>&1; then
  docker stop gobuntu 2>/dev/null
  docker rm gobuntu 2>/dev/null
fi

docker run -d \
	--name gobuntu \
>>>>>>> 1dca542d60972af064d18990d6bc826929161f51:scripts/gobuntu-de.sh
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

