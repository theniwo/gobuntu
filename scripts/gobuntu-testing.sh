docker run -d \
	--name gobuntu-testing \
	--hostname gobuntu-testing \
	--restart unless-stopped \
	--memory "512M" \
	--cap-add=NET_ADMIN \
	--cap-add=NET_RAW \
	-e TZ=Europe/Berlin \
	-p 44269:22 \
	-v gobuntu-testing_data:/root \
	-v gobuntu-testing_logs:/var/log \
	theniwo/gobuntu:testing

