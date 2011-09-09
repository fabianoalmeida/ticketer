function RedisClient() {
  if (! (this instanceof arguments.callee)) {
    return new arguments.callee(arguments);
  }

  var self = this;

  this.init = function() {
    self.setupBayeuxHandlers();
  };
  
  this.setupBayeuxHandlers = function() {
    // $.getJSON("/config.json", function (config) {
      self.client =  new Faye.Client("http://10.32.0.204:9292/faye", {
        timeout: 120
      });

      self.client.subscribe('/ticketer', function (message) {
        console.log("MESSAGE", message);
      });
    // });
  };

  this.init();
};

var redisClient;
jQuery(function() {
  redisClient = new RedisClient();
});