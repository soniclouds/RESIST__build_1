// Require the controllers
var events     = require('./../controllers/events.js');

// Define the routes
module.exports = function(app) {

// Event routes ===================================================
    app.get('/events', function(req, res) {
      events.getAll(req, res)
    });
    // app.get('/events/add', function(req, res){
    //   console.log("at add event");
    // })
    app.post('/events', function(req, res) {
      // events.addEvent
    });
};
