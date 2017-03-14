#!/bin/bash

# make new directory with built files
cd ..
cp -a sgd-docs built
cd built
git init

# make a commit and deploy to github pages
git config user.name "Travis"
git config user.email "sgdatuva@gmail.com"
git add .
git commit -m "Travis: generate HTML pages [ci skip]"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" > /dev/null 2>&1
