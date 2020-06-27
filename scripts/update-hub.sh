#!/usr/bin/env bash
cd /root/Settings/Linux/scripts/docker/gobuntu

	echo "Committing to docker hub"
	docker commit $(docker inspect --format='{{.ID}}' gobuntu) theniwo/gobuntu:latest && docker push theniwo/gobuntu:latest
	if [ $? -eq 0 ] ; then
		echo "Gobuntu has commited and automatically pushed to docker hub"
		logger -i -t gobuntu "Gobuntu has commited and automatically pushed to docker hub"
	else
		echo "Gobuntu has failed to commit and automatically push to docker hub"
		logger -i -t gobuntu "Gobuntu has failed to commit and automatically push to docker hub"
	fi

