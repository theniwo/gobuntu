#!/bin/bash
docker commit $(docker inspect --format='{{.ID}}' gobuntu) theniwo/gobuntu:latest && docker push theniwo/gobuntu:latest
if [ $? -eq 0 ] ; then
	logger -i -t gobuntu "Gobuntu has commited and automatically pushed to docker hub"
	else
	logger -i -t gobuntu "Gobuntu has failed to commit and automatically push to docker hub"

fi
