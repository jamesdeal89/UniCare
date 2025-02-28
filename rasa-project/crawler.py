
# web crawler from an old project - could be integrated to search for help links 

def get_url(url):
	import urllib.request 
	import urllib
	source = urllib.request.urlopen(url).read().decode('utf-8')
	return source

def getNextTarget(page):
	startLink = page.find("<a href=")
	if startLink == -1:
		return None, 0
	startQuote = page.find('"', startLink)
	endQuote = page.find('"', startQuote + 1)
	url = page[startQuote + 1 : endQuote]
	return url, endQuote

def findAllLinks(page):
	while True:
		url, endpos = getNextTarget(page)
		if url:
			print(url)
			page = page[endpos:]
		else:
			break

findAllLinks(get_url("https://notts-talk.co.uk/"))
