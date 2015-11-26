var markdown = require('markdown');
var _ = require('underscore');
var fs = require('fs');
var swig = require('swig');
var request = require('request');

var ten = process.argv.indexOf("ten") !== -1;

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
    if (ten) {
      album.data.body = album.data.body.replace('<p>', '');
      album.data.body = album.data.body.replace('</p>', '');
    }
    return album;
  });


  if (ten) {
    albums = albums.slice(0, 10);
  }

  var maxUps = Math.max.apply(Math, albums.map(function(album) { return album.data.ups; }))

  date = (new Date()).toString();
  var templateName = ten ? "ten.swig" : "main.swig"; 
  text = swig.render(fs.readFileSync(__dirname + "/" + templateName, "binary"), {
    locals: {
      albums: albums,
      date: date.substring(0, date.indexOf('201')+4),
      year: (new Date(data[0].data.children[0].data.created * 1000)).getFullYear(),
      url: url.replace(/\.json$/,''),
      maxUps: maxUps
    }
  });
  console.log(text);
});
