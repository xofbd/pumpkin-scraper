from scrapy import Field, Item


class SongItem(Item):
    files = Field()
    file_urls = Field()
