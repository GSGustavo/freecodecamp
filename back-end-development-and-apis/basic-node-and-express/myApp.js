const bodyParser = require('body-parser');
let express = require('express');
let app = express();
require('dotenv').config();

console.log("Hello World");


app.use("/", (req, res, next) => {
    console.log(`${req.method} ${req.path} - ${req.ip}`);
    next();
})

app.use(bodyParser.urlencoded({extended: false}));

app.use("/public", express.static(__dirname + '/public'))

app.get("/", (req, res) => {
    res.sendFile(__dirname + '/views/index.html');
});

app.get("/json", (req, res) => {
    const data = {
        message: "Hello json"
    }

    if (process.env.MESSAGE_STYLE === 'uppercase') {
        data.message = 'HELLO JSON';
    }

    res.json(data);
});

app.get("/now", (req, res, next) => {
    req.time = new Date().toString();
    next();
}, (req, res) => {
    res.json({
        time: req.time
    });
});

app.get("/:word/echo", (req, res) => {
    res.json({
        echo: req.params.word
    });
});

app.get("/name", (req, res) => {
    res.json({
        name: `${req.query.first} ${req.query.last}`
    });
}).post("/name", (req, res, next) => {
     res.json({
        name: `${req.body.first} ${req.body.last}`
    });
});

module.exports = app;


// route: POST '/library'
// urlencoded_body: userId=546&bookId=6754
// req.body: {userId: '546', bookId: '6754'}