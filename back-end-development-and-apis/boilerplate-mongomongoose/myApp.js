require('dotenv').config();
const mongoose = require('mongoose')

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})

let personSchema = new mongoose.Schema({
  name: {
    type: String,
    require: true
  },
  age: Number,
  favoriteFoods: [
    String
  ]
});

let Person = new mongoose.model("Person", personSchema);

const createAndSavePerson = (done) => {
  var Teste = new Person({
    name: "Gustavo Teste",
    age: 21,
    favoriteFoods: ['Maça', 'Pizza', 'Frutas']
  });

  Teste.save(function (err, data) {
    if (err) return console.error(err);
    done(null, data)
  });
};

const createManyPeople = (arrayOfPeople, done) => {

  Person.create(arrayOfPeople, function (err, data) {
    if (err) return console.error(err);
    done(null, data)
  });
};

const findPeopleByName = (personName, done) => {
  Person.find({ name: personName }, function (err, data) {
    if (err) return console.error(err);
    done(null, data)
  })
};

const findOneByFood = (food, done) => {
  Person.findOne({ favoriteFoods: food }, function (err, data) {
    if (err) return console.error(err);
    done(null, data)
  });
};

const findPersonById = (personId, done) => {

  Person.findById({ _id: personId }, function (err, data) {
    if (err) return console.error(err);
    done(null, data);
  })

};

const findEditThenSave = (personId, done) => {
  const foodToAdd = "hamburger";
  Person.findById(personId, (err, person) => {
    if (err) {
      return console.error(err)
    }
    person.favoriteFoods.push(foodToAdd)
    person.save((err, updatePerson) => {
      if (err) {
        return console.error(err)
      }
      done(null, updatePerson)
    })
  });
};

const findAndUpdate = (personName, done) => {
  const ageToSet = 20;

  Person.findOneAndUpdate({ name: personName }, { age: ageToSet }, {
    new: true
  }, (err, person) => {
    if (err) {
      return console.error(err)
    }
    done(null, person)
  });
};

const removeById = (personId, done) => {

  Person.findByIdAndRemove(personId, (err, person) => {
    if (err) {
      return console.error(err)
    }

    done(null, person)
  })

};

const removeManyPeople = (done) => {
  const nameToRemove = "Mary";

  Person.remove({ name: nameToRemove }, (err, data) => {
    if (err) {
      return console.error(err)
    }

    done(null, data)
  })
};

const queryChain = (done) => {
  const foodToSearch = "burrito";

  Person.find({ favoriteFoods: foodToSearch })
    .sort({ name: 0 })
    .limit(2)
    .select({age: 0})
    .exec((err, people) => {
      if (err) return console.error(err);

      done(null, people)
    })
};

/** **Well Done !!**
/* You completed these challenges, let's go celebrate !
 */

//----- **DO NOT EDIT BELOW THIS LINE** ----------------------------------

exports.PersonModel = Person;
exports.createAndSavePerson = createAndSavePerson;
exports.findPeopleByName = findPeopleByName;
exports.findOneByFood = findOneByFood;
exports.findPersonById = findPersonById;
exports.findEditThenSave = findEditThenSave;
exports.findAndUpdate = findAndUpdate;
exports.createManyPeople = createManyPeople;
exports.removeById = removeById;
exports.removeManyPeople = removeManyPeople;
exports.queryChain = queryChain;
