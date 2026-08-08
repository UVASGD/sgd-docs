# SGD Docs

Documents, tutorials, and tips designed to help members of [Student Game Developers at UVa](https://sgd.cs.virginia.edu/) and any other game developers! Topics will be added as the club learns about new tools and technologies.

##### Topics

* [Unity](unity/index.md)
* [Source Control](source/index.md)
* [Aseprite](aseprite/index.md) 
* [Resources for Jammers](jams/index.md)
* [GDC Write-ups](gdc/index.md)

### UVA Specific Material

* [SGD Constitution](uva/constitution.md)
* [Branding](uva/branding.md)
* [Booking Space](uva/space.md)

### Contributing

If you arrived via the GitHub Pages interface, [the repo is hosted on GitHub](https://github.com/UVASGD/sgd-docs). You may contribute by submitting changes in the form of [Markdown documents](#markdown-conversion-), and these changes will reflect on GitHub Pages automatically.

Before starting any new work, please review the following rules:

1. Changes are automatically published to the live site by GitHub Actions when pushed to the `master` branch.
2. If the Markdown doc links to internal images, add the image files to the repo. Images should be `.png` or `.jpg`.
3. If the Markdown doc links to internal text files, use the `.md` extension in the Markdown hyperlink; build scripts will convert that link to `.html` for the generated HTML files automatically. (NOTE: this makes linking external `.md` files tricky, as the script will attempt to convert those. If you need to do this, add an auxiliary character like `#` at the end of the link, a la `.md#`)
4. If the Markdown doc involves code snippets:
    * If the code is standalone, please upload files through [Gist](https://gist.github.com/) (name and add the scripts, and Create Secret Gist). Link the Markdown doc to the Gist.
    * If the code fits within the context of a GitHub project, then link the Markdown doc to the file on GitHub.
    * If the code is used for explanatory purposes in a tutorial (and is not very long), then embed it inline with the Markdown.
5. Include a _Back_ link that steps up the document tree hierarchy at the end of each document.
6. Add or update the "last updated" line at the top of the page.

If you would like to preview the HTML files locally before pushing the Markdown documents, run `Scripts/md-to-html.sh` from a shell whose current directory is the repo root directory. Some tips:

* To run `Scripts/md-to-html.sh`, [Pandoc](#markdown-conversion-) needs to be installed and added to the PATH.
* To run Bash scripts on Windows, use the [Windows Linux Subsystem](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide), [Cygwin](https://www.cygwin.com/), [MinGW](http://www.mingw.org/), or [Git Shell](https://desktop.github.com/).
* The HTML files should be gitignored, but in any case, do not push them to `master`.

Your support on this project is much appreciated! Feel free to reach out to the Head of Directors or Vice President (noted above) if you have any questions or concerns.

### Markdown Conversion [![Pandoc + Deploy Site](https://github.com/UVASGD/sgd-docs/actions/workflows/deploy-site.yml/badge.svg)](https://github.com/UVASGD/sgd-docs/actions/workflows/deploy-site.yml)

Content is written in [Markdown](https://daringfireball.net/projects/markdown/), as it is easy to write and renders well on GitHub; it is converted to HTML so it can be consumed on GitHub Pages as well. The conversion is handled by [Pandoc](http://pandoc.org/) with the help of scripts adapted from a UVa CS course. These scripts are run automatically through GitHub Actions whenever changes are made to the `master` branch.

### License

The material in this repo is released under [Creative Commons Attribution ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode).
[![Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)
