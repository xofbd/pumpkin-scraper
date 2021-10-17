import os
from urllib.parse import urlparse, unquote

from scrapy.pipelines.files import FilesPipeline


class SongFilesPipeline(FilesPipeline):
    def file_path(self, request, response=None, info=None, *, item=None):
        file_name = os.path.basename(unquote(urlparse(request.url).path))

        return os.path.join(info.spider.search_term, file_name)
