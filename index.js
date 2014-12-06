var markdown = require('markdown');
var _ = require('underscore');
var fs = require('fs');
var swig = require('swig');
var request = require('request');


var url = process.argv.pop();
request(url, function(err, res, body) {
  var data = JSON.parse(body);
  // get data
  // grab the comments bit
  var topLevelComments = data[1].data.children;
  // just the album-y things
  var albums = topLevelComments.filter(function(comment) {
    return comment && comment.data && comment.data.body && comment.data.body.split('\n')[0].match(/\-/);
  });
  // sort by votes
  albums = _(albums).sortBy(function(album) {
    return - album.data.ups;
  });
  // render comments to markdown
  albums.map(function(album) {
    album.data.body = markdown.markdown.toHTML(album.data.body.split('\n')[0]);
    return album;
  });
  date = (new Date()).toString();
  text = swig.render(fs.readFileSync(__dirname + "/main.swig", "binary"), {
    locals: {
      albums: albums,
      date: date.substring(0, date.indexOf('201')+4),
      year: (new Date(data[0].data.children[0].data.created * 1000)).getFullYear(),
      url: url.replace(/\.json$/,'')
    }
  });
  console.log(text);
});
