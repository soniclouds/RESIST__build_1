var express     = require("express"),
    path        = require("path"),
    bodyParser  = require("body-parser"),
    app         = express();
// require('colors');

require('./server/config/mongoose.js');
require('./server/config/routes.js')(app);

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());




app.listen(8000, function(){
  console.log("listening on port 8000");
})
