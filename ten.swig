<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="/tufte.css" />
<style>
.chart {
  padding-top: 3em;
}
.item {
  width: 100%;
  overflow: auto;
}
.label, .bar {
  float: left;
  width: 45%;
  margin: 1% 2%;
}
.label {
  text-align: right;
}
.guests {
  font-size: 80%;
}
</style>
<title>Top 10 Albums of {{ year }} as voted by Reddit</title>
</head>
<body>
  <article>
  <section>
    <h1>Top 10 Albums of {{ year }}</h1>
    <p><span class="marginnote"><a href="{{ url }}">as voted by reddit</a></span></p>
    <p><span class="marginnote">Last updated {{ date }}</span></p>
    <div class="chart sans">
    {% for album in albums %}
      <div class="item">
        <div class="label">
          {{ album.data.body|safe }} (#{{ loop.key + 1 }})
        </div>
        <div class="bar">
          <div style="display: inline-block; background-color: black; width: {{ 200 * album.data.ups / maxUps }}px;">.</div>
          <text>{{ album.data.ups }}</text>
        </div>
      </div>
    {% endfor %}
    </div>
  </section>
  </article>
</body>
</html>
