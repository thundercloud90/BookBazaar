// REST APIs for the book CRUD operations

var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var dbConnection = require('../config/database');


// POST: Create a new book posting
router.post('/', function (req, res, next) {
	// the query for the book table
	var sql = "INSERT INTO Books (Isbn, Bookname, Author, Condition, Edition) VALUES (?, ?, ?, ?, ?)";
	var inserts = [req.body.isbn, req.body.bookname, req.body.author, req.body.condition, req.body.edition];
	sql = mysql.format(sql, inserts);
	debug(sql);

	// the query for the postings table
	var postingsSql = "INSERT INTO Postings (Book_ISBN, Book_Price, User_PhoneNum) VALUES (?, ?, ?)";
	var postingInserts = [req.body.isbn, req.body.price, req.user.phonenumber];
	postingsSql = mysql.format(postingsSql, postingInserts);
	debug(postingsSql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
		{
			dbConnection.query(postingsSql, function (err, rows){
				if(err)
					res.json({success: 0, error: err});
				else
					res.json({success: 1});
			});
		}
	});
	next();

});


// POST: Update a book posting
router.post('/update', function (req, res) {

});


// POST: Remove book posting
router.post('/delete', function (req, res, next) {
	// query for deleting a posting
	var sql = "DELETE FROM Postings WHERE Book_ISBN=" + mysql.escape(req.body.isbn);
	debug(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1});
	});
	next();
});


// GET: search for a book
router.get('/search', function (req, res, next){
	var sql = "SELECT DISTINCT * FROM Books JOIN Postings ON Books.Isbn = Postings.Books_ISBN ";
	sql += "WHERE Isbn = ? OR Bookname = ? OR Author = ? OR Condition = ? OR Edition = ? ";
	sql += "ORDER BY TimePosted DESC";
	var inserts = [req.query.isbn, req.query.bookname, req.query.author, req.query.condition, req.query.edition];
	sql = mysql.format(sql, inserts);
	debug(sql);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.send({success: 0, error: err});
		else
			res.send({success: 1, books: rows});
	});
	next();
});


// GET: Retrieve books according to a certain user or category
router.get('/', function (req, res, next) {
	var sql = "SELECT * FROM Books JOIN Postings ON Books.Isbn = Postings.Books_ISBN ";

	if(req.query.phonenumber !== undefined)
	{
		sql += "WHERE User_PhoneNum = " + mysql.escape(req.query.phonenumber);
	}

	sql += " ORDER BY TimePosted DESC";
	debug(sql);

	dbConnection.query(sql, checkViewListings);
	next();
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