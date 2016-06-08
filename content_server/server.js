var express = require('express');
var app = express();
var PORT = 3000

app.get('/foo', function (req, res) {
  res.sendFile('content.html', {root: __dirname });
})

app.get('/bar', function(req, res) {
  res.status(500);
  res.send("Something went wrong :(")
})
 
console.log(`Listening on port ${PORT}`)
app.listen(PORT)

