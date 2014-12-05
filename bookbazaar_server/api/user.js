// REST APIs for the user CRUD operations

var passport = require('./app').passport;
var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('./app').dbConnection;


// POST: Create a new user account
router.post('/', passport.authenticate('local-signup', 
			{ successRedirect: '/', failureRedirect: '/login' }));


// POST: Login to existing account
router.post('/signin', passport.authenticate('local-login', 
			{ successRedirect: '/', failureRedirect: '/login' }));


// POST: Update account information
router.post('/update', function (req, res) {
  	
});


// POST: ban user
router.post('/ban', function (req, res){
	var sql = "UPDATE Login SET Baned = True WHERE User_PhoneNum = "+mysql.escape(req.body.phonenumber);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.send({success: 0, error: err});
		else
		{
			res.send({success: 1});
		}
	});
});

// GET: Check if Users is admin
router.get('/checkadmin', function (req, res){
	var sql = "SELECT IsAdmin FROM Users WHERE PhoneNum = " + mysql.escape(req.body.phonenumber);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.send({success: 0, error: err});
		else
		{
			
			if(rows[0].IsAdmin == 0)
				res.send({success: 1, IsAdmin: false});
			else
				res.send({success: 1, IsAdmin: true});
		}
	});
});


// GET: Retrieve account information
router.get('/', function (req, res) {
  	
});


// GET: Delete account from database
router.get('/delete', function (req, res) {
  	
});


module.exports = router;