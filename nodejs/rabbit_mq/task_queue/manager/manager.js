/**
 * @file Module to assign task
 * @author Gilson Varghese <gilsonvarghese7@gmail.com>
 * @version 0.0.1
 */

var amqp = require('amqplib');
var when = require('when');


var sendTask = function(msg) {
  console.log(msg);
  var q = 'task_queue';
  amqp.connect('amqp://localhost').then(function(conn) {
    return when(conn.createChannel().then(function(ch) {
      var q = 'task_queue';
      var ok = ch.assertQueue(q, {durable: true});
      
      return ok.then(function() {
        var msg = msg;
        ch.sendToQueue(q, new Buffer("sasa"));
        console.log(" [x] Sent '%s'", msg);
        return ch.close();
      });
    })).ensure(function() { conn.close(); });
  }).then(null, console.warn);

};

var arr = [];

for(var i = 0; i< 1000; ++i)
{
  sendTask("Task Number from task assigner " + i);
}