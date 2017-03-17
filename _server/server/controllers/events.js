// Require Mongoose
var mongoose = require('mongoose');

// Require the model and save it in a variable
var Event = mongoose.model('Event');

module.exports = (function() {
    return {
      getAll: function(req, res){
        Event.find({}, function(err, event){
          if(err){
            console.log("there was an error when getting all events".red);
          } else {
            console.log(event);
            console.log("successfully got all events".green);
            res.json(event);
          }
        });
      },

      addEvent: function(req, res) {
        console.log("===========================".yellow);
        console.log(req.body);
        console.log("===========================".yellow);

        var event = new Event({
          link: req.body.link,
          name: req.body.name,
          date: req.body.date,
          details: req.body.details,
          address: req.body.address,
          neighborhood: req.body.neighborhood,
          city: req.body.city,
          state: req.body.state,
          zip: req.body.zip,
          country: req.body.country
        })
        event.save(function(err){
          if(err){
            console.log("there was an error when saving an event".red);
          } else {
            console.log(event);
            console.log("successfully saved the above event".green);
            // '/tasks/all' is essentially a function that returns all tasks. therefore, 'output' = 'all tasks'
            res.redirect('/events/all');

          }
        })

      }


    }
})();
