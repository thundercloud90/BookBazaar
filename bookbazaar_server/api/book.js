// REST APIs for the book CRUD operations

var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('../config/database');


// POST: Create a new book posting
router.post('/', function (req, res, next) {
	
	// the query for the book table
	var sql = "INSERT INTO Books (`ISBN`, `BookName`, `Author`, `Condition`, `Edition`, `FileName`) VALUES (?, ?, ?, ?, ?, ?)";
	var inserts = [req.body.isbn, req.body.bookname, req.body.author, req.body.condition, req.body.edition, req.body.file];
	sql = mysql.format(sql, inserts);

	var postingInserts = [req.body.isbn, req.body.price, req.body.phonenumber];

	var testBook = "SELECT * FROM Books WHERE `ISBN` = "+mysql.escape(req.body.isbn);
	var testUser = "SELECT * FROM Users WHERE `PhoneNum` = "+mysql.escape(req.body.phonenumber);
	console.log(testUser);

	dbConnection.query(testUser, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else if(rows.length != 0){
			dbConnection.query(testBook, function (err, rows){
				if(err){
					res.json({success: 0, error: err})
				}
				else if(rows.length == 0){
					console.log("book doesn't exist");
					console.log(sql);
					dbConnection.query(sql, function (err, rows){
						if(err)
							res.json({success: 0, error: err});
						else
							postBook(req, res, postingInserts);
					});
				}
				else
					postBook(req, res, postingInserts);
			});
		}
		else
			res.json({success: 0, error: "User doesn't exist."});
	});
	
});

// used to actually add a book posting
function postBook (req, res, postingInserts){
	// the query for the Postings table
	var PostingsSql = "INSERT INTO Postings (`Books_ISBN`, `Price`, `User_PhoneNum`) VALUES (?, ?, ?)";
	PostingsSql = mysql.format(PostingsSql, postingInserts);

	console.log("adding to Postings");
	console.log(PostingsSql);
	dbConnection.query(PostingsSql, function (err, rows){ // either way add the posting
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1});
	});
};


// POST: Update a book posting
router.post('/update', function (req, res) {

});


// POST: Remove book posting
router.post('/delete', function (req, res, next) {
	// check if the book exists
	var sql = "SELECT * FROM Postings WHERE `Books_ISBN` = ? AND `User_PhoneNum` = ?";
	var inserts = [req.body.isbn, req.body.phonenumber];
	sql = mysql.format(sql, inserts);
    dbConnection.query(sql, function (err, rows){
    	if(err)
    		res.json({success: 0, error: err});
    	else if(rows.length == 0)
    		res.json({success: 0, error: "That posting doesn't exist."});
    	else{
    		// the posting exists
    		// query for deleting a posting
			sql = "DELETE FROM Postings WHERE `Books_ISBN` = ? AND `User_PhoneNum` = ?"; 
			sql = mysql.format(sql, inserts);

			dbConnection.query(sql, function (err, rows){
				if(err)
					res.json({success: 0, error: err});
				else
					res.json({success: 1});
			});
    	}
 
    });

	
});


// GET: search for a book
router.get('/search', function (req, res, next){
	var sql = "SELECT DISTINCT * "
	sql += "FROM Books JOIN Postings ON `Books`.`ISBN` = `Postings`.`Books_ISBN` ";
	sql += "WHERE `ISBN` LIKE ? OR `BookName` = ? OR `Author` LIKE ? OR `Condition` LIKE ? OR `Edition` LIKE ? ";
	sql += "ORDER BY `Timeposted` DESC";
	var inserts = [req.query.isbn !== undefined ? req.query.isbn : ""];
	inserts.push(req.query.bookname !== undefined ? req.query.bookname : "");
	inserts.push(req.query.author !== undefined ? req.query.author : "");
	inserts.push(req.query.condition !== undefined ? req.query.condition : "");
	inserts.push(req.query.edition !== undefined ? req.query.edition : "");
	sql = mysql.format(sql, inserts);
	console.log(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1, books: rows});
	});
});


// GET: Retrieve Books according to a certain user or all
router.get('/', function (req, res, next) {
	var sql = "SELECT * FROM Books JOIN Postings ON `Books`.`ISBN` = `Postings`.`Books_ISBN` ";
	console.log(req.query.phonenumber);
	if(req.query.phonenumber !== undefined)
	{
		sql += "WHERE `User_PhoneNum` = " + mysql.escape(req.query.phonenumber);
	}

	sql += " ORDER BY `TimePosted` DESC";

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1, books: rows});
	});
});

module.exports = router;