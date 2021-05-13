if docker inspect gobuntu-test >/dev/null 2>&1; then
  docker stop gobuntu-test 2>/dev/null
  docker rm gobuntu-test 2>/dev/null
fi
docker run -d \
        --name gobuntu-test \
        --hostname gobuntu-test \
        --restart no \
        --memory "128M" \
        --cap-add=NET_ADMIN \
        --cap-add=NET_RAW \
        -e TZ=Europe/Rome \
	-e LANG=it_IT.UTF-8 \
        -p 2223:22 \
        theniwo/gobuntu:latest
