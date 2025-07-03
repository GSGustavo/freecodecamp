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

		const userFind = await UserExercise.findOne({ _id: id });

		const username = userFind.username;

		const saveExercise = new Exercise({
			user_id: id,
			date: req.body.date ? new Date(req.body.date.split('-')[0], req.body.date.split('-')[1], req.body.date.split('-')[2]) : null,
			description: req.body.description,
			duration: req.body.duration
		});

		const data = await saveExercise.save();

		res.json(
			{
				_id: id,
				username: userFind.username,
				date: data.date ? data.date.toDateString() : null,
				description: data.description,
				duration: data.duration
			}
		);

	} catch (error) {
		console.error(error);
		res.json({
			error: "error"
		})
	}

});

app.get("/api/users/:_id/logs", async (req, res) => {

	// /api/users/:_id/logs?[from][&to][&limit]

	const id = req.params._id;


	try {

		const userFind = await UserExercise.findOne({ _id: id });

		if (userFind) {

			try {

				const from = req.query.from;
				const to = req.query.to;
				const limit = req.query.limit;

				console.log(`_id: ${id}, from: ${from}, to: ${to}, limit: ${limit}`);

				// Build date filter
				let dateFilter = {};

				// Build base query
				let query = Exercise.find({ user_id: id });

				// Apply date filter if needed
				if (from || to) {
					query = query.where('date');
				}

				if (from) {
					dateFilter.$gte = new Date(from);
					query = query.gte(dateFilter.$gte);
				}

				if (to) {
					dateFilter.$lte = new Date(to)
					query = query.lte(dateFilter.$lte);
				}

				query = query.select(
					{
						'description': 1,
						'duration': 1,
						'date': 1,
						'_id': 0
					}
				);

				// Apply limit if needed
				if (limit) {
					query = query.limit(Number(limit));
				}

				// Execute query
				let log = await query.exec();

				log = log.map((el) => {
					return {
						description: el.description,
						duration: el.duration,
						date: el.date ? el.date.toDateString() : null
					}
				})

				const count = log.length

				res.json({
					_id: id,
					username: userFind.username,
					count: count,
					log: log
				})

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
// "_id": "68632ace509d2d00132fea1c",
// "username": "teste",
// "count": 2,
// "log": [
// {
// "description": "testando 123",
// "duration": 30,
// "date": "Mon Jun 30 2025"
// },
// {
// "description": "testando 123",
// "duration": 30,
// "date": "Mon Jun 30 2025"
// }
// ]
// }