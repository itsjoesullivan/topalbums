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
<title>Top Albums of {{ context.year }} as voted by Reddit</title>
</head>
<body>
  <div class="container">
    <h1>Top Albums of {{ context.year }}</h1>
    <h2><a href="{{ url }}">as voted by reddit</a></h2>
    <p class=updated>Last updated {{ context.date }}</p>
    <table cellpadding="5">
      <tr>
        <th>Rank</th>
        <th>Ups</th>
        <th>Description</th>
      </tr>
      {% for album in context.albums %}
        <tr>
          <td>{{ loop.index + 1 }}</td>
          <td>{{ album.data.ups }}</td>
          <td>{{ album.data.body|safe }}</td>
        </tr>
      {% endfor %}
    </table>
  </div>
</body>
</html>
