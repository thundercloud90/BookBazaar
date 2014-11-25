// using passport to login and signup and authenticate sessions
// http://orchestrate.io/blog/2014/06/26/build-user-authentication-with-node-js-express-passport-and-orchestrate/
// https://gist.github.com/manjeshpv/84446e6aa5b3689e8b84

// basic REST - API example
// http://blog.modulus.io/nodejs-and-express-create-rest-api

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');

// database - mysql
var mysql = require('mysql');
var dbConnection = mysql.createConnection({
                  host     : 'localhost',
                  database : 'bookBazaar',
                  user     : 'root',
                  password : ''
                });
connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  console.log('connected as id ' + connection.threadId);
});
exports.dbConnection = dbConnection;

// session modules
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var RedisStore = require('connect-redis')(session);

// authentication
var passport = require('passport');
var passportConfig = require('./config/passport');
passportConfig(passport);
exports.passport = passport;

// routing 
var routes = require('./routes/index');
var user = require('./api/user');
var book = require('./api/book');
var abuse = require('./api/abuse');

var app = express();

// uncomment after placing your favicon in /public
//app.use(favicon(__dirname + '/public/favicon.ico'));
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
    cookie: { } 
    secret: 'B00kb@3aAR' }));

app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
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


module.exports = app;
