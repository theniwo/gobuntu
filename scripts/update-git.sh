#!/usr/bin/env bash

FRIENDLYNAME=Gobuntu
CONTAINERNAME=gobuntu
DOCKERIMAGE=gobuntu
DOCKERREPO=theniwo
DOCKERTAG=latest
DIR=/root/Settings/Linux/scripts/docker
PARAMETER="$1"


cd $DIR/$CONTAINERNAME

function main(){
	logger -i -t $CONTAINERNAME "Adding files"
	git add .
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Adding files successful"
	  else
	    logger -i -t $CONTAINERNAME "Adding files unsuccessful"
	  fi


	logger -i -t $CONTAINERNAME "Committing to git"
	git commit --all -m "Auto commit"
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Committing to git successful"
	  else
	    logger -i -t $CONTAINERNAME "Committing to git failed"
	  fi

	logger -i -t $CONTAINERNAME "Pushing to git"
	git push origin master
	  if [ $? -eq 0 ] ; then
	    logger -i -t $CONTAINERNAME "Pushing to git successful"
	  else
	    logger -i -t $CONTAINERNAME "Pushing to git unsuccessful"
	  fi
}

if [[ $PARAMETER == "--force" ]] || [[ $PARAMETER == "-f" ]]; then
  echo "Forcing Commit"
  date +%Y%m%d%H%M%S > $DIR/$CONTAINERNAME/CHANGEFILE
fi
main
