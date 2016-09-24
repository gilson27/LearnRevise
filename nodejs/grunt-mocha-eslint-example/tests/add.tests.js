/**
  Load all libraries
*/

var expect = require("chai").expect;
var add = require("../test_modules/add/add");


describe("add", function() {
  it('should give sum on passing variables', function() {
    expect(add.add(5,6)).to.equal(11);
    expect(add.add(-33333,-66666)).to.equal(-99999);
  })
});