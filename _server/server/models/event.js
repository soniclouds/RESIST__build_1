// Require Mongoose
var mongoose = require('mongoose');

// Create the schema
var EventSchema = new mongoose.Schema({
    link: {type: String, required: true},
    name: {type: String, required: true},
    date: {type: Date, required: true},
    details: {type: String},
    address: {type: String},
    neighborhood: {type: String},
    city: {type: String},
    state: {type: String},
    zip: {type: String},
    country: {type: String},
}, {timestamps: true});

mongoose.model('Event', EventSchema); // We are setting this Schema in our Models as 'Event'
module.exports = mongoose.model('Event')
