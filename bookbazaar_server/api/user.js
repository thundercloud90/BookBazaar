// REST APIs for the user CRUD operations

var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('../config/database');


// POST: create an account
router.post('/signup', function (req, res){
	// checks if the email is already used
    var sql = "SELECT * FROM Login WHERE `UsersName` = "+mysql.escape(req.body.email);
    dbConnection.query(sql, function (err, rows){
		if (err)
            res.json({success: 0, error: err});
		else if (rows.length) {
            	res.json({success: 0, error: "That email address is already taken."});
        } 
        else {
        	// checks if the phone number is already used
        	sql = "SELECT * FROM Login WHERE `User_PhoneNum` = "+mysql.escape(req.body.phonenumber);
        	dbConnection.query(sql, function (err, rows){
				if(err)
					res.json({success: 0, error: err});
				else if(rows.length)
					res.json({success: 0, error: "That phone number is already taken."});
				else{
					// if there is no user with that email or phone number
		            // create the user in Users first then Login
			    	var insertUsers = "INSERT INTO Users (`PhoneNum`, `Email`, `FirstName`, `LastName`, `Street`, `City`, `State`, `ZipCode`, `IsAdmin`, `AvatarFilename`) ";
		            insertUsers += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		            inserts = [req.body.phonenumber, req.body.email, req.body.firstname, req.body.lastname, req.body.street, req.body.city, req.body.state, req.body.zipcode, req.body.isadmin, req.body.avatarfilename];
		            insertUsers = mysql.format(insertUsers, inserts);
					
					dbConnection.query(insertUsers, function (err,rows){
					    if(err)
		                    res.json({success: 0, error: err});
					    else{
				            var insertLogin = "INSERT INTO Login ( `UsersName`, `Password`, `User_PhoneNum` ) VALUES (?, ?, ?) ";
				            var inserts = [req.body.email, req.body.password, req.body.phonenumber];
				            insertLogin = mysql.format(insertLogin, inserts);

					    	dbConnection.query(insertLogin, function (err, rows){
					    		if(err)
					    			res.json({success: 0, error: err});
					    		else{
					    			res.json({success: 1})
					    		}	
					    	});
					    }
					});	
				}
        	});
			
        }	
	});
});


// POST: login to existing accound
router.post('/login', function (req, res){
	var sql = "SELECT * FROM Login WHERE `UsersName` = " + mysql.escape(req.body.email);
    dbConnection.query(sql, function (err,rows){
		if (err)
            res.json({success: 0, error: err});
		else if (rows.length == 0) {
            res.json({success: 0, error: "No user with that email address was found."}); 
        } 
		
		// if the user is found but the password is wrong
        else if (!( rows[0].Password == req.body.password))
            res.json({success: 0, error: "Incorrect password."});
		
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

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1});
	});
});

// GET: Check if Users is admin
router.get('/checkadmin', function (req, res, next){
	var sql = "SELECT `IsAdmin` FROM Users WHERE `PhoneNum` = " + mysql.escape(req.query.phonenumber);
	console.log(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});

		else if(rows.length == 0)
			res.json({success: 0, error: "User does not exist"});

		else
			res.json({success: 1, IsAdmin: rows[0].IsAdmin});
	});
});


// GET: Retrieve account information
router.get('/', function (req, res) {
  	
});


// GET: Delete account from database
router.get('/delete', function (req, res) {
	
});


module.exports = router;