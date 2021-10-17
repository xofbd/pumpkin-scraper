SPIDER_MODULES = ['pumpkin.spiders']
MEDIA_ALLOW_REDIRECTS = True
ITEM_PIPELINES = {'pumpkin.pipelines.SongFilesPipeline': 100}
FILES_STORE = 'songs'
