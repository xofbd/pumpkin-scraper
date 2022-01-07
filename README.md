# The Pumpkin Scraper: Searching and Scraping Songs from The Smashing Pumpkins 🎃 🔨
This projects uses the Python package [Scrapy](https://scrapy.org/) to download a chosen [The Smashing Pumpkins](https://smashingpumpkins.com/) song from the [Internet Archive](https://archive.org/). 🎃

## Prerequisites
1. Python 3.8 or above
1. (optional) [Poetry](https://python-poetry.org/)

## Install
**Note:** If you'd like to use [Docker](https://www.docker.com/), skip to [Running with Docker](#running-with-docker).

If you have GNU Make and Poetry installed, you can install the project via `make install`. If you don't have Poetry and GNU Make, you can create a [virtual environment](https://docs.python.org/3/tutorial/venv.html) using the `requirements.txt` file. For example:

* `python3 -m venv venv`
* `source venv/bin/activate` or `venv\Scripts\activate` in Windows
* `pip install -r requirements.txt`

## Usage
To download a song, run the Bash script via `bin/download <search-term>`. For example, `bin/run "set the ray to jerry"`. It will then search the archive for recordings of that song and download them to the directory `songs/<searh-term>`. Specifically, the Scrapy spider will crawl through all search results download audio files where the search term string appears in the file URL. Note: you can run the Scrapy spider directly with `scrapy crawl pumpkin -a search_term=<search-term>`.

## Running with Docker
To run with [Docker](https://www.docker.com/), you'll need to first build the image and then run a container using that image. You can run `make docker-image` to build the image or run:

`docker build -t pumpkin --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .`

To run the container, you can use the Bash script `bin/docker-run <search-term>` or run:

`docker run --rm -v $PWD/songs:/project/songs pumpkin <search-term>`

See the [Usage](#usage) section for more information about how `<search-term>` works.

## License
This project is distributed under the MIT license. Please see `LICENSE` for more information.
