# SGD Docs

Documents, tutorials, and tips designed to help members of [Student Game Developers at UVa](http://sgd.cs.virginia.edu/) and any other game developers! Topics will be added as the club learns about new tools and technologies.

* [Unity](unity/index.md)
* [Aseprite](aseprite/index.md) 
* [Resources for Jammers](jams/index.md)
* [UVa Specific Material](uva/index.md)

### Contributing

If you arrived via the GitHub Pages interface, [the repo is hosted on GitHub](https://github.com/UVASGD/sgd-docs). Please fork the `master` branch (or make a separate branch if you're a collaborator), add more content in the form of [Markdown documents](#markdown-conversion), and submit a pull request. Some scripts will deploy your contributions to GitHub pages automatically. The `gh-pages` branch should only have HTML generated from the build system, whereas `master` should only have Markdown; therefore, the two branches should be kept independent of each other (i.e. do not merge them). Some formatting rules:

* Content files like CSS and images should be uploaded to `master`; from there they will be copied to `gh-pages` automatically. 
* If the Markdown doc links to internal images, add the image files to the repo. Images should be `.png` or `.jpg`.
* If the Markdown doc links to internal text files, use the `.md` extension in the Markdown hyperlink; the script will convert that link to `.html` for the generated HTML files automatically. (NOTE: this makes linking external `.md` files tricky, as the script will attempt to convert those. If you need to do this, add an auxiliary character like `#` at the end of the link, a la `.md#`)
* Include a _Back_ link that steps up the document tree hierarchy at the end of each document.

If you would like to preview the HTML files locally before pushing the Markdown documents, run `Scripts/md-to-html.sh` from a shell whose current directory is the repo root directory. Some tips:

* To run `Scripts/md-to-html.sh`, [Pandoc](#markdown-conversion) needs to be installed and added to the PATH.
* To run Bash scripts on Windows, use the [Windows Linux Subsystem](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide), [Cygwin](https://www.cygwin.com/), [MinGW](http://www.mingw.org/), or [Git Shell](https://desktop.github.com/).
* The HTML files should be gitignored, but in any case, do not upload them to `master`.

### Markdown Conversion [![](https://travis-ci.org/UVASGD/sgd-docs.svg?branch=master)](https://travis-ci.org/UVASGD/sgd-docs)

Content is written in [Markdown](https://daringfireball.net/projects/markdown/), as it is easy to write and renders well on GitHub; it is converted to HTML so it can be consumed on GitHub Pages as well. The conversion is handled by [Pandoc](http://pandoc.org/) with the help of scripts adapted from a UVa CS course. These scripts are run automatically through [Travis CI](https://travis-ci.org/UVASGD/sgd-docs) whenever changes are made to the `master` branch.

### License

The material in this repo is released under [Creative Commons Attribution ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode).
[![Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)