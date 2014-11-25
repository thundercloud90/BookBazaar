// REST APIs for the abuse report CRUD operations

var passport = require('./app').passport;
var express = require('express');
var router = express.Router();


// POST: Create a new abuse report
router.post('/', function (req, res) {

});


// POST: Remove abuse report
router.post('/delete', function (req, res) {

});


// GET: Retrieve all abuse reports, intended for the admin
router.get('/', function (req, res) {
	
});


module.exports = router;