// REST APIs for the user CRUD operations

var passport = require('./app').passport;
var express = require('express');
var router = express.Router();


// POST: Create a new user account
router.post('/', passport.authenticate('local-signup', 
			{ successRedirect: '/', failureRedirect: '/login' }));


// POST: Login to existing account
router.post('/signin', passport.authenticate('local-login', 
			{ successRedirect: '/', failureRedirect: '/login' }));


// POST: Update account information
router.post('/update', function (req, res) {
  	
});


// GET: Retrieve account information
router.get('/', function (req, res) {
  	
});


// GET: Delete account from database
router.get('/delete', function (req, res) {
  	
});


module.exports = router;