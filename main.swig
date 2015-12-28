<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width">
<style>
  body {
    font-family: inconsolata;
  }
  .container {
    max-width: 800px;
    margin: auto;
  }
  
  .container {
    border-style: double;
    border-color: black;
    border-width: 10px;
    padding: 1em;
  }
  tr {
        border: 1px solid black;
        margin: 0;
  }
  h1, h2 {
    text-align: center;
  }

  h1 {
    line-height:1em;
  }
  .updated {
    text-align: right;
  }
</style>
<title>Top Albums of {{ year }} as voted by Reddit</title>
</head>
<body>
  <div class="container">
    <p style="text-align: right;">Website by <a href="http://twitter.com/itsjoesullivan">@itsjoesullivan</a></p>
    <h1>Top Albums of {{ year }}</h1>
    <h2><a href="{{ url }}">as voted by reddit</a></h2>
    <p class=updated>Last updated {{ date }}</p>
    <table cellpadding="5">
      <tr>
        <th>Rank</th>
        <th>Ups</th>
        <th>Description</th>
      </tr>
      {% for album in albums %}
        <tr>
          <td>{{ loop.key+1 }}</td>
          <td>{{ album.data.ups }}</td>
          <td>{{ album.data.body|safe }}</td>
        </tr>
      {% endfor %}
    </table>
  </div>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-70763169-1', 'auto');
  ga('send', 'pageview');
</script>
</body>
</html>
