#!/bin/bash

# make a commit on gh-pages branch and push to deploy
cd ..
git clone --depth=50 --branch=gh-pages https://github.com/UVASGD/sgd-docs.git sgd-docs-ghp
rsync -avm --include='*.html' \
	--include '*.png' \
	--include '*.jpg' \
	--include '*.css' \
	--include '*.ico' \
	--filter='hide,! */' sgd-docs/ sgd-docs-ghp
cd sgd-docs-ghp
git config user.name "Travis"
git config user.email "sgdatuva@gmail.com"
git add .
git commit -m "Travis: generate HTML pages [ci skip]"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" > /dev/null 2>&1
