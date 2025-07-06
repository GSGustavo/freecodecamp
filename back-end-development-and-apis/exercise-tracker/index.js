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
		res.json({
			error: "error"
		})
	}
}).get("/api/users", async (req, res) => {
	try {

		const data = await UserExercise.find();

		res.json(data)

	} catch (error) {

		console.error(error);
		res.json({
			error: "error"
		})

	}
});

app.post("/api/users/:_id/exercises", async (req, res) => {

	const id = req.params._id;

	try {

		const userFind = await UserExercise.findOne({ _id: id });

		const username = userFind.username;

		const dateToSave = {
			user_id: id,
			description: req.body.description,
			duration: req.body.duration,
			date: new Date()
		}

		if (req.body.date) {
			dateToSave.date = new Date(req.body.date.split('-')[0], req.body.date.split('-')[1] - 1, req.body.date.split('-')[2])
		}

		const saveExercise = new Exercise(dateToSave);

		const data = await saveExercise.save();

		const dataToReturn = {
			_id: id,
			username: username,
			description: data.description,
			duration: data.duration
		}

		if (data.date) {
			dataToReturn.date = data.date.toDateString()
		}

		dataToReturn.date

		res.json(dataToReturn);

	} catch (error) {
		console.error(error);
		res.json({
			error: "error"
		})
	}

});

app.get("/api/users/:_id/logs", async (req, res) => {

	const id = req.params._id;

	try {

		const userFind = await UserExercise.findOne({ _id: id });

		if (userFind) {

			try {
				const from = req.query.from;
				const to = req.query.to;
				const limit = req.query.limit;

				let dateFilter = {};

				if (from) dateFilter.$gte = new Date(from.split('-')[0], from.split('-')[1] - 1, from.split('-')[2]);
				if (to) dateFilter.$lte = new Date(to.split('-')[0], to.split('-')[1] - 1, to.split('-')[2]);

				console.log(">>>>>>> _id: ", id);
				console.log(">>>>>>> from: ", from);
				console.log(">>>>>>> to: ", to);
				console.log(">>>>>>> limit: ", limit);
				console.log(">>>>>>> dateFilter: ", JSON.stringify(dateFilter));

				// Combine all filters
				const mongoFilter = {
					user_id: id,
					...(from || to ? { date: dateFilter } : {})
				};

				let query = Exercise.find(mongoFilter)
					.select({
						description: 1,
						duration: 1,
						date: 1,
						_id: 0,
					});

				if (limit) {
					query = query.limit(limit);
				}

				let log = await query.exec();

				log = log.map((el) => {
					const logToReturn = {
						description: el.description,
						duration: el.duration,
					}

					if (el.date) {
						logToReturn.date = el.date.toDateString()
					}

					return logToReturn
				})

				const count = log.length

				const jsonToReturn = {
					_id: id,
					username: userFind.username,
					count: count,
					log: log
				}

				if (from) {
					jsonToReturn.from = from.split('-')[0], from.split('-')[1], from.split('-')[2]
				}

				if (to) {
					jsonToReturn.to = to.split('-')[0], to.split('-')[1], to.split('-')[2]
				}

				res.json(jsonToReturn)

			} catch (error) {
				console.error(error);
				res.json({
					error: "error"
				})
			}

		} else {
			res.json({
				error: "invalid user"
			})
		}

	} catch (error) {
		console.error(error);
		res.json({
			error: "error"
		})
	}

});

const listener = app.listen(process.env.PORT || 3000, () => {
	console.log('Your app is listening on port ' + listener.address().port)
})

// running tests
// 12. Each item in the log array that is returned from GET /api/users/:_id/logs is an object that should have a description, duration, and date properties.
// 15. The date property of any object in the log array that is returned from GET /api/users/:_id/logs should be a string. Use the dateString format of the Date API.
// tests completed

// {
//     "_id": "6865e2c1914ee5c98c819aa1",
//     "username": "test3",
//     "count": 1,
//     "log": [
//         {
//             "description": "teste",
//             "duration": 30,
//             "date": "Wed Apr 30 2025"
//         }
//     ]
// }


// {
// 	"_id": "68632ace509d2d00132fea1c",
// 	"username": "teste",
// 	"count": 2,
// 	"log": [
// 			{
// 				"description": "testando 123",
// 				"duration": 30,
// 				"date": "Mon Jun 30 2025"
// 			},
// 			{
// 				"description": "testando 123",
// 				"duration": 30,
// 				"date": "Mon Jun 30 2025"
// 			}
// 	]
// }