// REST APIs for the book CRUD operations

var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('../config/database');


// POST: Create a new book posting
router.post('/', function (req, res, next) {
	
	// the query for the book table
	var sql = "INSERT INTO books (`ISBN`, `BookName`, `Author`, `Condition`, `Edition`) VALUES (?, ?, ?, ?, ?)";
	var inserts = [req.body.isbn, req.body.bookname, req.body.author, req.body.condition, req.body.edition];
	sql = mysql.format(sql, inserts);

	// the query for the postings table
	var postingsSql = "INSERT INTO postings (`Books_ISBN`, `Book_Price`, `User_PhoneNum`) VALUES (?, ?, ?)";
	var postingInserts = [req.body.isbn, req.body.price, req.body.phonenumber];
	postingsSql = mysql.format(postingsSql, postingInserts);

	var test = "SELECT * FROM books WHERE `ISBN` = "+mysql.escape(req.body.isbn);

	dbConnection.query(test, function (err, rows){
		if(err){
			res.json({success: 0, error: err});
			return;
		}
		else if(rows.length == 0){  // if the book doesn't exist create a new one
			
			dbConnection.query(sql, function (err, rows){
				if(err)
					res.json({success: 0, error: err});
			});
		}
		dbConnection.query(postingsSql, function (err, rows){ // either way add the posting
			if(err)
				res.json({success: 0, error: err});
			else
				res.json({success: 1});
		});
	});
});


// POST: Update a book posting
router.post('/update', function (req, res) {

});


// POST: Remove book posting
router.post('/delete', function (req, res, next) {
	// query for deleting a posting
	var sql = "DELETE FROM Postings WHERE `Book_ISBN` = ? AND `User_PhoneNum` = ?"; 
	var inserts = [req.body.isbn, req.body.phonenumber];
	sql = mysql.format(sql, inserts);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1});
	});
});


// GET: search for a book
router.get('/search', function (req, res, next){
	var sql = "SELECT DISTINCT `BookName`, `Author`, `FileName`, `Condition`, `Edition`, `TimePosted`, `Postings`.`User_PhoneNum`, `Price`"
	sql += "FROM books JOIN postings ON `books.ISBN` = `postings.Books_ISBN` ";
	sql += "WHERE `ISBN` = ? OR `BookName` = ? OR `Author` = ? OR `Condition` = ? OR `Edition` = ? ";
	sql += "ORDER BY `Timeposted` DESC";
	var inserts = [req.query.isbn !== undefined ? req.query.isbn : 0];
	inserts.push(req.query.bookname !== undefined ? req.query.bookname : "");
	inserts.push(req.query.author !== undefined ? req.query.author : "");
	inserts.push(req.query.condition !== undefined ? req.query.condition : "");
	inserts.push(req.query.edition !== undefined ? req.query.edition : "");
	sql = mysql.format(sql, inserts);
	console.log(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.send({success: 0, error: err});
		else
			res.send({success: 1, books: rows});
	});
});


// GET: Retrieve books according to a certain user or category
router.get('/', function (req, res, next) {
	var sql = "SELECT * FROM books JOIN postings ON `books`.`ISBN` = `postings`.`books_ISBN` ";

	if(req.query.phonenumber !== undefined)
	{
		sql += "WHERE `User_PhoneNum` = " + mysql.escape(req.query.phonenumber);
	}

	sql += " ORDER BY `TimePosted` DESC";

	dbConnection.query(sql, checkViewListings);
});

// the callback function for viewListings
function checkViewListings(err, rows)
{
	if(err)
		res.send({success: 0, error: err});
	else
		res.send({success: 1, books: rows});
}


module.exports = router;