// database - mysql
var mysql = require('mysql');
var dbConnection = mysql.createConnection({
                  host     : 'localhost',
                  database : 'bookBazaar',
                  user     : 'cs3450',
                  password : 'cs3450'
                });

dbConnection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }
  console.log('connected as id ' + dbConnection.threadId);
});

module.exports = dbConnection;