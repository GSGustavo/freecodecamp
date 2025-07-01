const express = require('express')
const app = express()
const cors = require('cors')
require('dotenv').config()
const mongoose = require('mongoose')

app.use(cors())

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static('public'))

app.use("/", (req, res, next) => {
	console.log(`${req.method} ${req.path} - ${req.ip}`);
	console.log(`body: ${JSON.stringify(req.body)}`)
	console.log(`params: ${JSON.stringify(req.params)}`)
	console.log(`query: ${JSON.stringify(req.query)}`)

	next();
})

app.get('/', (req, res) => {
	res.sendFile(__dirname + '/views/index.html')
});

mongoose.connect(process.env.MONGO_URI, {
	useNewUrlParser: true,
	useUnifiedTopology: true
})

let userExerciseSchema = new mongoose.Schema({
	username: {
		type: String,
		require: true
	}
});

let UserExercise = new mongoose.model("UserExercise", userExerciseSchema);

let exerciseSchema = new mongoose.Schema({
	user_id: {
		type: String,
		require: true
	},
	description: {
		type: String,
		require: true
	},
	duration: {
		type: Number,
		require: true,

	},
	date: {
		type: Date,
		require: true
	}
});

let Exercise = new mongoose.model("Exercise", exerciseSchema);

// 686335d31533ae790567c41c / gustavo.gonzaga

app.post("/api/users", async (req, res) => {
	const username = req.body.username;

	const saveData = {
		username: username
	};

	try {
		const data = await new UserExercise(saveData).save();
		res.json({
			"_id": data._id,
			"username": data.username
		})
	} catch (error) {
		console.error(error);
	}
});

app.post("/api/users/:_id/exercises", async (req, res) => {

	// description, duration, date

	// {
	//     "_id": "68632ace509d2d00132fea1c",
	//     "username": "teste",
	//     "date": "Mon Jun 30 2025",
	//     "duration": 30,
	//     "description": "testando 123"
	// }

	const id = req.params._id;

	try {

		const userFind = await UserExercise.findOne({_id: id});

		const username = userFind.username;

		const saveExercise = new Exercise({
			date: new Date(req.body.date),
			description: req.body.description,
			duration: req.body.duration
		});

		const data = await saveExercise.save();

		res.json({
			_id: id,
			username: userFind.username,
			date: data.date.toDateString(),
			description: data.description,
			duration: data.duration
		});

	} catch (error) {
		console.error(error);
	}

});

app.post("/api/users/:_id/logs", (req, res) => { // ?[from][&to][&limit]

	const id = req.params._id;
	const from = req.query.from;
	const to = req.query.to;
	const limit = req.query.limit;



});

const listener = app.listen(process.env.PORT || 3000, () => {
	console.log('Your app is listening on port ' + listener.address().port)
})
