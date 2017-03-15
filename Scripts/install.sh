#!/bin/bash

# The Debian package manager downloads an old version of Pandoc, so we download a newer version ourselves
# To download latest version (not hard-coded number), look at https://gist.github.com/rossant/8b751a15d71d6d9403a8

echo "Downloading Pandoc v1.19.2 package"
wget "https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb" -O ../pandoc.deb

echo "Installing Pandoc"
sudo dpkg -i ../pandoc.deb
