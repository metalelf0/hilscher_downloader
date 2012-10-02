`http://github.com/metalelf0/hilscher_downloader`

DESCRIPTION
---

This command line ruby application is made to download pictures from
[Blake Hilscher Wallpaper Collection](http://wallpaper.hilscher.ca/).

It features [Thor](https://github.com/wycats/thor) as a command line
utility wrapper, [Nokogiri](http://nokogiri.org/) as an HTML parser,
[Faraday](https://github.com/technoweenie/faraday) as an HTTP client,
[VCR](https://github.com/myronmarston/vcr) to stub requests in tests and
of course rspec for the tests.

Feel free to browse the code, suggest fixes, different implementations
and whatever comes to your mind :)

SYNOPSIS
---

Launch the script with the `thor download:homepage` or `thor
download:all` commands. They both accept the following parameters:

* `-f` or `--force-overwrite=`: overwrite already downloaded pictures
  (default: `false`)
* `-d` or `--download-dir=`: the download directory. Default is `/tmp`.
  The script creates a `hilscher_pictures` directory inside of it.

DEPENDENCIES
---

This app requires `wget` to be installed on your machine. If you are on
OSX you can install it with homebrew.

INSTALL
---

Clone the repository, `bundle install` and you are done.

CREDITS
---

Of course this app is based on the great work done by [Blake
Hilscher](https://github.com/blakehilscher/Photo-Wall), and I'd like to
thank him for sharing his great HD wallpapers collection - great work!

