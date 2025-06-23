// index.js
// where your node app starts

// init project
require('dotenv').config();
var express = require('express');
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC
var cors = require('cors');
app.use(cors({ optionsSuccessStatus: 200 })); // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static('public'));

app.use("/", (req, res, next) => {
  console.log(`${req.method} ${req.path} - ${req.ip}`);
  console.log({
    "ipaddress": req.ip,
    "language": req.header('Accept-Language'),
    "software": req.header('user-agent')
  })
  next();
})

// http://expressjs.com/en/starter/basic-routing.html
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/views/index.html');
});

// your first API endpoint...
app.get('/api/hello', function (req, res) {
  res.json({ greeting: 'hello API' });
});

app.get("/api/whoami", (req, res) => {

  //  {
  // "ipaddress": "162.158.155.140",
  // "language": "en-US,en;q=0.9,pt;q=0.8,af;q=0.7",
  // "software": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36"
  // }

  res.json({
    "ipaddress": req.ip,
    "language": req.header('Accept-Language'),
    "software": req.header('user-agent')
  })

})

// listen for requests :)
var listener = app.listen(process.env.PORT || 3000, function () {
  console.log('Your app is listening on port ' + listener.address().port);
});
