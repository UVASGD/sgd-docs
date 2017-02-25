#!/bin/bash

# Markdown to HTML conversion adapted from script on https://github.com/aaronbloomfield/pdr

# take every path in filesystem ending with .md
for infile in `find . | grep '\.md$'`; do
	# HTML page title is the header of MD file
    pagetitle=`head -1 $infile | sed -r 's/#\s*//g'`
	# HTML filename is the same as MD filename with extension replaced
    outfile=`echo $infile | sed -r 's/md$/html/g'`
	# derive css link from file's location in system (NOTE: filenames should not contain '/')
	cssprefix=`echo $infile | tr -d -c '/' | sed -r 's/^\///g' | sed -r 's/\//..\//g'`
	# transform the file by replacing .md hyperlinks with .html equivalents
	# then use pandoc to handle the conversion, linking the css file
	cat $infile | \
	sed -r 's/\.md\s*\)/.html)/g' | \
    pandoc -V "pagetitle:$pagetitle" \
		-r markdown \
		-w html \
		-c "${cssprefix}modest.css" \
		-o $outfile
done
