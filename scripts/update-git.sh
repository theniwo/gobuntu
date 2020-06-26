#!/usr/bin/env bash

	git add .
	  logger -i -t gobuntu "Adding files"
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Adding files successful"
	  else
	    logger -i -t gobuntu "Adding files unsuccessful"
	  fi

	git commit --all -m "Auto commit"
	  logger -i -t gobuntu "Committing to git"
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Committing to git success"
	  else
	    logger -i -t gobuntu "Committing to git failed"
	  fi

	git push origin master
	  logger -i -t gobuntu "Pushing to git"
	  if [ $? -eq 0 ] ; then
	    logger -i -t gobuntu "Pushing to git successful"
	  else
	    logger -i -t gobuntu "Pushing to git unsuccessful"
	  fi

