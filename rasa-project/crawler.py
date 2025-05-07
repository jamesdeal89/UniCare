
# web crawler from an old project - could be integrated to search for help links 

import urllib.request 
import urllib

def get_url(url):
	try:
		source = urllib.request.urlopen(url).read().decode('utf-8')
	except:
		print("LOG: there was an error in accessing ", url, " it will not be crawled this time.")
		return None
	else:
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
	urls = []
	if page:
		while True:
			url, endpos = getNextTarget(page)
			if url:
				urls.append(url)
				page = page[endpos:]
			else:
				break
	else:
		pass
	return urls

