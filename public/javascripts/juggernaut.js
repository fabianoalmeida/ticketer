jQuery(function($){

  var juggernaut = { 

    init : function(){ 


   	var client =  new Faye.Client("http://"+ window.location.hostname +":8080/faye", {
       	timeout: 120
   	});

    client.subscribe('/ticketer', process);
      // 
      // $('body').bind('ajaxSend', this.proxy(function(e, xhr){
      //     xhr.setRequestHeader('X-Session-ID', this.socket.sessionID);
      // }));
    }, 

    proxy: function(func){       
      var thisObject = this;
      return(function(){
        return func.apply(thisObject, arguments);
      });
    }
  };
  
  /* This method was created with intention to update dynamically the counter of a specific counter type.
   * Should be passed the type of the column that should update the values.
   * Basic usage:
   *
   * $.changeByOneValues( "available", 1, false );
   *
   */
  $.changeByOneValues = function(type, id, up){
    //Update value from top.
    size = $('ul#tickets_' + type + '.holder li').size();
    $('span#tickets_' + type + '_total').html('<i>Total: '+size+'</i>');

    //Update values from tag
    tag = 'ul#tickets_' + type + '_tag #ticket_type' + id;
    current_value = parseInt($(tag).text());

    if (current_value != 0) {
      //If current_value has a NaN or undefined as value the condition should be false
      if (current_value != current_value) { 
        current_value = 0;
      }
      up ? $(tag).text(current_value + 1) : $(tag).text(current_value == 1 ? '' : current_value - 1);
    }
  }

  window.juggernaut = juggernaut.init();
});
