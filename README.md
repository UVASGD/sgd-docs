# SGD Docs

Documents, tutorials, and tips designed to help members of [Student Game Developers at UVa](http://sgd.cs.virginia.edu/) and any other game developers! Topics will be added as the club learns about new tools and technologies.

* [Unity](unity/index.md)
* [Aseprite](aseprite/index.md) 
* [Resources for Jammers](jams/index.md)
* [GDC Write-ups](gdc/index.md)
* [UVa Specific Material](uva/index.md)

### Contributing

If you arrived via the GitHub Pages interface, [the repo is hosted on GitHub](https://github.com/UVASGD/sgd-docs). You may contribute by submitting changes in the form of [Markdown documents](#markdown-conversion-build), and these changes will reflect on GitHub Pages automatically.

* SGD officers or directors: you may push minor changes directly to `master`. For new content, please create a separate branch and submit a pull request.
* All other collaborators: please fork the repository, add your changes, and then submit a pull request. The request shall be reviewed by SGD's Head of Directors ([Jackson Ekis](https://github.com/ferociouself)) or Vice President ([Zachary Danz](https://github.com/zsd4yr)).

Before starting any new work, please review the following rules:

* Do not push updates to the `gh-pages` branch; it will be updated automatically on changes to `master`.
* Asset files like CSS and images should be uploaded to `master`; from there they will be copied to `gh-pages` automatically. 
* If the Markdown doc links to internal images, add the image files to the repo. Images should be `.png` or `.jpg`.
* If the Markdown doc links to internal text files, use the `.md` extension in the Markdown hyperlink; build scripts will convert that link to `.html` for the generated HTML files automatically. (NOTE: this makes linking external `.md` files tricky, as the script will attempt to convert those. If you need to do this, add an auxiliary character like `#` at the end of the link, a la `.md#`)
* If the Markdown doc involves code snippets:
    * If the code is standalone, please upload files through [Gist](https://gist.github.com/) (name and add the scripts, and Create Secret Gist). Link the Markdown doc to the Gist.
    * If the code fits within the context of a GitHub project, then link the Markdown doc to the file on GitHub.
    * If the code is used for explanatory purposes in a tutorial (and is not very long), then embed it inline with the Markdown.
* Include a _Back_ link that steps up the document tree hierarchy at the end of each document.

If you would like to preview the HTML files locally before pushing the Markdown documents, run `Scripts/md-to-html.sh` from a shell whose current directory is the repo root directory. Some tips:

* To run `Scripts/md-to-html.sh`, [Pandoc](#markdown-conversion-build) needs to be installed and added to the PATH.
* To run Bash scripts on Windows, use the [Windows Linux Subsystem](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide), [Cygwin](https://www.cygwin.com/), [MinGW](http://www.mingw.org/), or [Git Shell](https://desktop.github.com/).
* The HTML files should be gitignored, but in any case, do not push them to `master`.

Your support on this project is much appreciated! Feel free to reach out to the Head of Directors or Vice President (noted above) if you have any questions or concerns.

### Markdown Conversion [![Build](https://travis-ci.org/UVASGD/sgd-docs.svg?branch=master)](https://travis-ci.org/UVASGD/sgd-docs)

Content is written in [Markdown](https://daringfireball.net/projects/markdown/), as it is easy to write and renders well on GitHub; it is converted to HTML so it can be consumed on GitHub Pages as well. The conversion is handled by [Pandoc](http://pandoc.org/) with the help of scripts adapted from a UVa CS course. These scripts are run automatically through [Travis CI](https://travis-ci.org/UVASGD/sgd-docs) whenever changes are made to the `master` branch.

### License

The material in this repo is released under [Creative Commons Attribution ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode).
[![Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)