#!/usr/bin/env bash
echo "Adding all files"
git add .
echo "Committing"
git commit --all -m "Auto commit"
echo "pushing"
git push origin master

