require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
const mongoose = require('mongoose')
const dns = require('dns').promises;

mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

let urlSchema = new mongoose.Schema({
    original_url: {
        type: String,
        require: true
    },
    short_url: {
        type: Number,
        require: true
    }
});

let UrlSchema = new mongoose.model("Url", urlSchema);

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/", (req, res, next) => {
    console.log(`${req.method} ${req.path} - ${req.ip}`);
    console.log(`body: ${JSON.stringify(req.body)}`)
    console.log(`params: ${JSON.stringify(req.params)}`)
    console.log(`query: ${JSON.stringify(req.query)}`)

    next();
})

app.use(cors());

app.use('/public', express.static(`${process.cwd()}/public`));

app.get('/', function (req, res) {
    res.sendFile(process.cwd() + '/views/index.html');
});

// Your first API endpoint
app.get('/api/hello', function (req, res) {
    res.json({ greeting: 'hello API' });
});

app.listen(port, function () {
    console.log(`Listening on port ${port}`);
});

// const urlPattern = /(https:\/\/www\.|http:\/\/www\.|https:\/\/|http:\/\/)?[a-zA-Z0-9]{2,}(\.[a-zA-Z0-9]{2,})(\.[a-zA-Z0-9]{2,})?/;

const urlPattern = /^(https?:\/\/)?(www\.)?([a-zA-Z0-9\-\.]+|\blocalhost\b)(:\d+)?(\/.*)?$/;

app.post('/api/shorturl', async (req, res) => {

    const bodyUrl = req.body.url;

    const match = urlPattern.test(bodyUrl)

    if (match && bodyUrl) {

        const parsedUrl = new URL(bodyUrl);
        const hostname = parsedUrl.hostname;

        try {
            const address = await dns.lookup(hostname, { family: 4 });

            const resJson = {
                original_url: "",
                short_url: 0
            }

            try {
                // https://freecodecamp.org/

                const lengthSearchUrl = bodyUrl.length
                const urlFormatted = bodyUrl[lengthSearchUrl - 1] === '/' ? bodyUrl.slice(0, lengthSearchUrl - 1) : bodyUrl

                console.log(`Searching for... "${urlFormatted}"`)

                const data = await UrlSchema.find({ original_url: urlFormatted })

                if (data.length === 0) {

                    console.log(`"${urlFormatted}" created!`)

                    let urlCounter = await UrlSchema.countDocuments();

                    const newShorUrl = urlCounter + 1

                    var newUrl = new UrlSchema({
                        original_url: urlFormatted,
                        short_url: newShorUrl
                    });

                    try {
                        const data = await newUrl.save();

                        resJson.original_url = urlFormatted;
                        resJson.short_url = newShorUrl;

                    } catch (error) {
                        res.status(500).json(
                            {
                                error: "error"
                            }
                        )
                    }

                } else {
                    const document = data[0]
                    resJson.original_url = document.original_url;
                    resJson.short_url = document.short_url;

                    console.log(JSON.stringify(resJson))
                }

            } catch (error) {
                res.json(
                    {
                        error: "error"
                    }
                )
            }

            res.json(resJson)


        } catch (error) {

            res.json(
                {
                    error: "Invalid URL"
                }
            )

        }


    } else {
        res.json(
            {
                error: "Invalid URL"
            }
        )
    }
});

app.get("/api/shorturl/:short_url", async (req, res) => {
    try {
        const data = await UrlSchema.find({ short_url: req.params.short_url })

        if (data.length === 0) {
            throw new Error("URL not find.");
        } else {
            const original_url = data[0].original_url

            res.redirect(original_url)
        }

    } catch (error) {
        res.send("Not found")
    }
})
