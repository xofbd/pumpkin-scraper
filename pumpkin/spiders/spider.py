from urllib.parse import unquote, urlencode
from scrapy import Request, Spider
from pumpkin.items import SongItem


class Pumpkin(Spider):
    name = 'pumpkin'

    def start_requests(self):
        """Return request object for the page with all identified albums"""
        query_string = urlencode(
            {'query': 'smashing pumpkins ' + self.search_term.lower()}
        )
        url = 'https://archive.org/search.php?' + query_string

        yield Request(url, self.parse)

    def parse(self, response):
        for link in response.css('div.C234 a'):
            yield response.follow(link, self.parse_album)

    def parse_album(self, response):
        """Parse album page to get all URLs of music files"""
        for link in response.css('link[itemprop="associatedMedia"]::attr(href)'):
            if self.check_song(link.get()):
                yield SongItem(file_urls=[link.get()])

    def check_song(self, url):
        """Return Boolean if the song file URL is for the searched song."""
        file_name = unquote(url.split('/')[-1])

        return self.search_term.lower() in file_name.lower()
