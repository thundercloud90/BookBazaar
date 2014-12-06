// using passport to login and signup and authenticate sessions
// http://orchestrate.io/blog/2014/06/26/build-user-authentication-with-node-js-express-passport-and-orchestrate/
// https://gist.github.com/manjeshpv/84446e6aa5b3689e8b84

// basic REST - API example
// http://blog.modulus.io/nodejs-and-express-create-rest-api

// core modules
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');

// session modules
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var RedisStore = require('connect-redis')(session);

// routing files
//var routes = require('./routes/index');
var passport = require('./config/passport');
var user = require('./api/user');
var book = require('./api/book');
var abuse = require('./api/abuse');

var app = express();


app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(session({ 
    store: new RedisStore({
        host:'127.0.0.1',
        port:6380,
        prefix:'sess'
    }),
    resave: false,
    saveUninitialized: true, 
    secret: 'B00kb@3aAR' 
  }));

app.use(express.static(path.join(__dirname, '/public/html')));
app.use(express.static(path.join(__dirname, '/public')));

//app.use('/', routes);
app.use('/account', passport);
app.use('/users', user);
app.use('/book', book);
app.use('/abuse', abuse);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handlers
/*
// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});
*/
app.set('port', process.env.PORT || 3000);

var server = app.listen(app.get('port'), function() {
  console.log('Express server listening on port ' + server.address().port);
});
