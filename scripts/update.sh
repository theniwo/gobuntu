#!/usr/bin/env bash

function update-git(){
	echo "Adding all files to HEAD"
	git add .
	echo "Committing git"
	git commit --all -m "Auto commit"
	echo "pushing to git"
	git push origin master
}

function update-docker(){
	echo "Committing to docker hub"
	docker commit $(docker inspect --format='{{.ID}}' gobuntu) theniwo/gobuntu:latest && docker push theniwo/gobuntu:latest
	if [ $? -eq 0 ] ; then
		echo "Gobuntu has commited and automatically pushed to docker hub"
		logger -i -t gobuntu "Gobuntu has commited and automatically pushed to docker hub"
	else
		echo "Gobuntu has failed to commit and automatically push to docker hub"
		logger -i -t gobuntu "Gobuntu has failed to commit and automatically push to docker hub"
	fi
}

var="$1"
case "$var" in
   git)
   	update-git
        ;;
   docker)
	update-docker
        ;;
   *)
   	echo Use either "$0" git or docker
   	;;
esac
