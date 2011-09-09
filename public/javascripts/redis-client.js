function RedisClient() {
  if (! (this instanceof arguments.callee)) {
    return new arguments.callee(arguments);
  }

  var self = this;

  this.init = function() {
    self.drawMap();
    self.viewDidResize();
    self.setupBayeuxHandlers();
  };
  
  this.setupBayeuxHandlers = function() {
    $.getJSON("/config.json", function (config) {
      self.client =  new Faye.Client("http://" + window.location.hostname + ':' + config.port + '/faye', {
        timeout: 120
      });

      self.client.subscribe('/stat', function (message) {
        console.log("MESSAGE", message);
      });
    });
  };
  self.init();
};

var redisClient;
jQuery(function() {
  redisClient = new RedisClient();
});