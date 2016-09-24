/**
	@author Gilson Varghese <gilsonvarghese7@gmail.com>
	@file To run test addition program
	@license MIT
*/

var add = require("./add/add");

/**
	Runs the program
	@function
*/

var startApp = function() {
	var x = 255;
	var y = 789;
	var z = add.add(x,y);
	console.log("Result of x + y = ", z);
}

module.exports.start = startApp;