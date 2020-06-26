#!/bin/bash

	logger -i -t gobuntu "Adding files"
	git add /root/Settings/Linux/scripts/docker/gobuntu/*
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Adding files successful"
	  else
	    logger -i -t gobuntu "Adding files unsuccessful"
	  fi


	logger -i -t gobuntu "Committing to git"
	git commit --all -m "Auto commit"
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Committing to git successful"
	  else
	    logger -i -t gobuntu "Committing to git failed"
	  fi

	logger -i -t gobuntu "Pushing to git"
	git push /root/Settings/Linux/scripts/docker/gobuntu origin master
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Pushing to git successful"
	  else
	    logger -i -t gobuntu "Pushing to git unsuccessful"
	  fi

