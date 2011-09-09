process.addListener('uncaughtException', function (err, stack) {
  console.log('------------------------');
  console.log('Exception: ' + err);
  console.log(err.stack);
  console.log('------------------------');
});

var Ticketer = require(__dirname+'/lib/ticketer');

new Ticketer({
  	port	: 8080
  , server 	: "/ticketer"
});
