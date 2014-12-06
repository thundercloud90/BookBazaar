// REST APIs for the user CRUD operations

var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('../config/database');


// POST: create an account
router.post('/signup', function (req, res){
	// find a user whose email is the same as the forms email
	// we are checking to see if the user trying to login already exists
    var sql = "SELECT * FROM Login WHERE `UserName` = "+dbConnection.escape(email);
    dbConnection.query(sql, function (err, rows){
		if (err)
            res.json({success: 0, error: err});
		if (rows.length) {
            res.json({success: 0, error: "That email address is already taken."});
        } 
        else {

			// if there is no user with that email
            // create the user
			var insertQuery = "INSERT INTO Login ( `UserName`, `Password`, `User_PhoneNum` ) VALUES (?, ?, ?)";
            var inserts = [req.body.email, req.body.password, req.body.phonenumber];
            insertQuery = mysql.format(insertQuery, inserts);
            insertQuery += "INSERT INTO Users (`PhoneNum`, `Email`, `FirstName`, `LastName`, `Street`, `City`, `State`, `ZipCode`, `IsAdmin`, `AvatarFilename`) ";
            insertQuery += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            inserts = [req.body.phonenumber, req.body.email, req.body.firstname, req.body.lastname, req.body.street, req.body.city, req.body.state, req.body.zipcode, req.body.isadmin, req.body.avatarfilename];
            insertQuery = mysql.format(insertQuery, inserts);

			console.log(insertQuery);
			dbConnection.query(insertQuery, function (err,rows){
			    if(err)
                    res.json({success: 0, error: err});
			    else
			    	res.json({success: 1})
			});	
        }	
	});
});


// POST: login to existing accound
router.post('/login', function (req, res){
	var sql = "SELECT * FROM Login WHERE `UserName` = " + dbConnection.escape(req.body.email);
    dbConnection.query(sql, function (err,rows){
		if (err)
            res.json({success: 0, error: err});
		else if (!rows.length) {
            res.json({success: 0, error: "No user found."}); 
        } 
		
		// if the user is found but the password is wrong
        else if (!( rows[0].password == password))
            res.json({success: 0, error: "Incorrect password."});  // create the loginMessage and save it to session as flashdata
		
        else
        	res.json({success: 1, phonenumber: rows[0].User_PhoneNum})		
	
	});
});


// POST: Update account information
router.post('/update', function (req, res) {
  	
});


// POST: ban user
router.post('/ban', function (req, res, next){
	var sql = "UPDATE Login SET `Baned` = True WHERE `User_PhoneNum` = "+mysql.escape(req.body.phonenumber);
	debug(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.send({success: 0, error: err});
		else
		{
			res.send({success: 1});
		}

	});
	next();
});

// GET: Check if Users is admin
router.get('/checkadmin', function (req, res, next){
	var sql = "SELECT `IsAdmin` FROM Users WHERE `PhoneNum` = " + mysql.escape(req.body.phonenumber);
	debug(sql);

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
	next();
});


// GET: Retrieve account information
router.get('/', function (req, res) {
  	
});


// GET: Delete account from database
router.get('/delete', function (req, res) {
  	
});


module.exports = router;