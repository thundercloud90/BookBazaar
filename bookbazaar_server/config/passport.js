// config/passport.js
				
// load all the things we need
var express = require('express');
var router = express.Router();
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var mysql = require('mysql');
var dbConnection = require('./database');
 
// expose this function to our app using module.exports
function passportConfig(passport) {
 
	// =========================================================================
    // passport session setup ==================================================
    // =========================================================================
    // required for persistent login sessions
    // passport needs ability to serialize and unserialize users out of session
 
    // used to serialize the user for the session
    passport.serializeUser(function (user, done) {
		done(null, user.id);
    });
 
    // used to deserialize the user from the session
    passport.deserializeUser(function (id, done) {
		User.findById(id, function (err, user) {
            done(err, user);
        });
    });
	
 
 	// =========================================================================
    // LOCAL SIGNUP ============================================================
    // =========================================================================
    // we are using named strategies since we have one for login and one for signup
	// by default, if there was no name, it would just be called 'local'
 
    passport.use('local-signup', new LocalStrategy({
        passReqToCallback : true // allows us to pass back the entire request to the callback
    },
    function (req, email, password, done) {
 
		// find a user whose email is the same as the forms email
		// we are checking to see if the user trying to login already exists
        var sql = "SELECT * FROM Login WHERE UserName = "+dbConnection.escape(email);
        dbConnection.query(sql, function (err, rows){
			console.log(rows);
			console.log("above row object");
			if (err)
                return done(err);
			if (rows.length) {
                return done(null, false, req.flash('signupMessage', 'That email address is already taken.'));
            } else {
 
				// if there is no user with that email
                // create the user
                var newUserMysql = new Object();
				
				newUserMysql.email    = email;
                newUserMysql.password = password; 
                newUserMysql.phonenumber = req.body.phonenumber;
			
				var insertQuery = "INSERT INTO Login ( UserName, Password, User_PhoneNum ) VALUES (?, ?, ?)";
                var inserts = [email, password, req.body.phonenumber];
                insertQuery = mysql.format(insertQuery, inserts);
                insertQuery += "INSERT INTO Users (PhoneNum, Email, FirstName, LastName, Street, City, State, ZipCode, IsAdmin, AvatarFilename) ";
                insertQuery += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                inserts = [req.body.phonenumber, email, req.body.firstname, req.body.lastname, req.body.street, req.body.city, req.body.state, req.body.zipcode, req.body.isadmin, req.body.avatarfilename];
                insertQuery = mysql.format(insertQuery, inserts);

				console.log(insertQuery);
				dbConnection.query(insertQuery,function(err,rows){
				    if(err)
                        return done(err);
				    return done(null, newUserMysql);
				});	
            }	
		});
    }));
 
    // =========================================================================
    // LOCAL LOGIN =============================================================
    // =========================================================================
    // we are using named strategies since we have one for login and one for signup
    // by default, if there was no name, it would just be called 'local'
 
    passport.use('local-login', new LocalStrategy({
        passReqToCallback : true // allows us to pass back the entire request to the callback
    },
    function (req, email, password, done) { // callback with email and password from our form
 
        var sql = "SELECT * FROM Login WHERE UserName = " + dbConnection.escape(email);
        dbConnection.query(sql, function (err,rows){
			if (err)
                return done(err);
			 if (!rows.length) {
                return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
            } 
			
			// if the user is found but the password is wrong
            if (!( rows[0].password == password))
                return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.')); // create the loginMessage and save it to session as flashdata
			
            // all is well, return successful user
            return done(null, rows[0]);			
		
		});
    }));
};

passportConfig(passport);

// POST: Create a new user account
router.post('/signup', passport.authenticate('local-signup', 
            { successRedirect: '/', failureRedirect: '/login' }));


// POST: Login to existing account
router.post('/signin', passport.authenticate('local-login', 
            { successRedirect: '/', failureRedirect: '/login' }));

module.exports = router;