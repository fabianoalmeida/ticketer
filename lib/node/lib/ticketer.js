var http 	 = require('http'),
	sys      = require('sys'),
	static   = require('node-static'),
	faye     = require('faye'),
	url      = require('url'),
	redis    = require('redis'),
	io 		 = require('socket.io');


function Ticketer(options) {
	
  if (! (this instanceof arguments.callee)) {
    return new arguments.callee(arguments);
  };

  var self = this;

  self.settings = {
    	port	: options.port
 	,   channel : options.server
  };

  self.init();
};

Ticketer.prototype.init = function() {

  var self = this;

  self.bayeux = self.createBayeuxServer();


  self.redisClient = self.createRedisServer(self.bayeux);
  self.httpServer = self.createHTTPServer();
  // self.bayeux.(8000);
  self.bayeux.attach(self.httpServer);
  // self.io = self.createSocketIo(self.httpServer);

  self.httpServer.listen(self.settings.port);
  sys.log('Server started on PORT ' + self.settings.port);

};

Ticketer.prototype.createSocketIo = function(httpServer){
	var sio =  io.listen(httpServer);
	sio.sockets.on('connection', function(socket) {
		socket.emit('/ticketer', {hello : 'world'});
		socket.on('/ticketer', function(data) {
			console.log("- Message : " + data);
		});
	});
	
	sio.sockets.on('message', function(message) {
		console.log("- Message : " + message);
	})
	
	return sio;
}

Ticketer.prototype.createRedisServer = function(bayeux){
	
  var self = this;
  
  var redisPublisher  = redis.createClient(),
	  redisListener   = redis.createClient(),
	  clientBayeux 	  = bayeux.getClient();
  	
  clientBayeux.subscribe(self.settings.channel);

  redisListener.on("message", function(channel, message) {
	clientBayeux.publish(channel, JSON.parse(message));
	self.io.emit(channel, JSON.parse(message));
  });

  redisListener.subscribe(self.settings.channel);

  return redisPublisher;
};

Ticketer.prototype.createBayeuxServer = function() {
	
  var self = this;

  var bayeux = new faye.NodeAdapter({
    	mount: '/faye'
    ,   timeout: 45
  });
	
  return bayeux;
};

Ticketer.prototype.createHTTPServer = function() {

  var self = this;

  var server = http.createServer(function(request, response) {
 	var file = new static.Server('./public', {
      cache: false
    });

    request.addListener('end', function() {
      var location = url.parse(request.url, true),
          params   = (location.query || request.headers);

      if (location.pathname == '/config.json' && request.method == "GET") {
        response.writeHead(200, {
          'Content-Type': 'application/x-javascript'
        });

        var jsonString = JSON.stringify({
          port: self.settings.port
        });

        response.end(jsonString);

      } else {
        file.serve(request, response);
      }
    });
  });

  return server;
};

module.exports = Ticketer;