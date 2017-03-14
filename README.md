# SGD Docs

Documents, tutorials, and tips designed to help members of [Student Game Developers at UVa](http://sgd.cs.virginia.edu/) and any other game developers! Topics will be added as the club learns about new tools and technologies.

---

1. [Unity](unity/index.md)
2. [Booking Space](space/index.md)

### Contributing

If you arrived via the Github Pages interface, [the repo is hosted on Github](https://github.com/UVASGD/sgd-docs). Please fork the repo, add more content in the form of Markdown documents (see below), regenerate the HTML files by running the `md-to-html.sh` script with a shell in the repo's root directory, and submit a pull request. A couple notes:

* If the Markdown doc links to internal images, add the image files to the repo as well.
* If the Markdown doc links to internal text files, use the `md` extension in the Markdown; the script will convert that link to `html` for the HTML files automatically.
* To run the script, Pandoc (see below) needs to be installed and added to the PATH.
* To run the script on Windows, use the [Windows Linux Subsystem](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide) or [Cygwin](https://www.cygwin.com/).

### Markdown conversion

Content is written in [Markdown](https://daringfireball.net/projects/markdown/), as it is easy to write and renders well on Github; it is converted to HTML so it can be consumed on Github Pages as well. The conversion is handled by [Pandoc](http://pandoc.org/) with the help of scripts adapted from a UVa CS course.

### License

The material in this repo is released under [Creative Commons Attribution ShareAlike 4.0](https://creativecommons.org/licenses/by-sa/4.0/legalcode).
[![Creative Commons](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)