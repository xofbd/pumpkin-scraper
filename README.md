# The Pumpkin Scraper: Searching and Scraping Songs from The Smashing Pumpkins 🎃  🔨
This projects uses the Python package [Scrapy](https://scrapy.org/) to download a chosen [The Smashing Pumpkins](https://smashingpumpkins.com/) song from the [Internet Archive](https://archive.org/). 🔨 

## Prerequisites
1. Python 3
1. (optional) [Poetry](https://python-poetry.org/)

## Install
If you have GNU Make and Poetry installed, you can install the project via `make install`. If you don't have Poetry and GNU Make, you can create a [virtual environment](https://docs.python.org/3/tutorial/venv.html) using the `requirements.txt` file. For example:

* `python3 -m venv venv`
* `source venv/bin/activate` or `venv\Scripts\activate` in Windows
* `pip install -r requirements.txt`

## Usage
To download a song, run the Bash script via `bin/download <search-term>`. For example, `bin/run "set the ray to jerry"`. It will then search the archive for recordings of that song and download them to the directory `songs/<searh-term>`. Specifically, the Scrapy spider will crawl through all search results download audio files where the search term string appears in the file URL. Note: you can run the Scrapy spider directly with `scrapy crawl pumpkin -a search_term=<search-term>`.

## License
This project is distributed under the MIT license. Please see `LICENSE` for more information.
