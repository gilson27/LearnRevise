var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

/** GET API Version */
router.get('/api/version', function(req, res, next) {
  var jsonResponse = {"version": "v1"};
  res.status(200);
  res.json(jsonResponse);
  res.end();
});
module.exports = router;
