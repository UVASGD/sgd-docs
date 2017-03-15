#!/bin/bash

# make a commit and deploy to github pages
git checkout --track origin/gh-pages
git config user.name "Travis"
git config user.email "sgdatuva@gmail.com"
git add .
git commit -m "Travis: generate HTML pages [ci skip]"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" > /dev/null 2>&1
