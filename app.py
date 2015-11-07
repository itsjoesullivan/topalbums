import sys
import requests
import re
import markdown2
import datetime
from jinja2 import Environment, FileSystemLoader
import os

headers = {
  'User-Agent': "hello"
}
r = requests.get(sys.argv[1], headers=headers)
topLevelComments = r.json()[1]["data"]["children"]
print len(topLevelComments)

albumyTest = re.compile(" ")
def isAlbumy(comment):
	if "body" not in comment["data"].keys():
		return False
	firstLine = comment["data"]["body"].split("\n")[0]
	result = albumyTest.search(firstLine)
	return result
albums = filter(isAlbumy, topLevelComments)

def sortByVotes(commentA, commentB):
	return commentA["data"]["ups"] < commentB["data"]["ups"]
albums.sort(sortByVotes)

def convertBodyToHTML(album):
	albumCopy = album.copy()
	htmlBody = markdown2.markdown(albumCopy["data"]["body"].split('\n')[0])
	albumCopy["data"]["body"] = htmlBody
	return albumCopy
htmlAlbumList = map(convertBodyToHTML, albums)
context = {
	"albums": htmlAlbumList,
	"date": datetime.datetime.now(),
	"year": 1234,
	"url": sys.argv[1]
}
j2_env = Environment(loader=FileSystemLoader("./"),
	trim_blocks=True)
print j2_env.get_template('main.swig').render(
	context=context
)
