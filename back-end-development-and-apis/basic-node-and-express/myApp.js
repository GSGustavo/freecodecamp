let express = require('express');
let app = express();
require('dotenv').config()

console.log("Hello World")

// app.get("/", (req, res) => {
//     res.send("Hello Express");
// });

app.use("/public", express.static(__dirname + '/public'))

app.get("/", (req, res) => {
    res.sendFile(__dirname + '/views/index.html');
});

app.get("/json", (req, res) => {
    const data = {
        message: "Hello json"
    }

    if (process.env.MESSAGE_STYLE === 'uppercase') {
        data.message = 'HELLO JSON'
    }

    res.json(data)
})

module.exports = app;
