// REST APIs for the book CRUD operations

var passport = require('./app').passport;
var express = require('express');
var router = express.Router();
var mysql = require('mysql')
var dbConnection = require('./app').dbConnection;


// POST: Create a new book posting
router.post('/', function (req, res) {
	// the query for the book table
	var sql = "INSERT INTO Books (Isbn, Bookname, Author, Condition, Edition) VALUES (?, ?, ?, ?, ?)";
	var inserts = [req.body.isbn, req.body.bookname, req.body.author, req.body.condition, req.body.edition];
	sql = mysql.format(sql, inserts);

	// the query for the postings table
	var postingsSql = "INSERT INTO Posting (Book_ISBN, Phonenumber) VALUES (?, ?)";
	var postingInserts = [req.body.isbn, req.user.phonenumber];
	postingsSql = mysql.format(postingsSql, postingInserts);

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


});


// POST: Update a book posting
router.post('/update', function (req, res) {

});


// POST: Remove book posting
router.post('/delete', function (req, res) {
	// query for deleting a posting
	var sql = "DELETE FROM Postings WHERE Book_ISBN=" + mysql.escape(req.body.isbn);

	dbConnection.query(sql, function (err, rows){
		if(err)
			res.json({success: 0, error: err});
		else
			res.json({success: 1});
	});
});


// GET: Retrieve books according to a certain user or category
router.get('/', function (req, res) {
	
});


module.exports = router;