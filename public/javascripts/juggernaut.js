jQuery(function($){

  var juggernaut = { 

    init : function(){ 
      this.socket = new Juggernaut; 
      this.offline = function(){ 
                      $.facebox("A conexão foi encerrada inesperadamente! <br /> " + 
    		      "Porfavor verifique se o computador está conectado  <br/> "+ 
                      "corretamente a rede, e atualize a página."); 
                  } 
      this.socket.on("disconnect", this.proxy(this.disconnect));
      this.socket.subscribe('/ticketer',process);
      $('body').bind('ajaxSend', this.proxy(function(e, xhr){
          xhr.setRequestHeader('X-Session-ID', this.socket.sessionID);
      }));
    }, 

    disconnect: function(){
      this.offline();
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
