jQuery(function($){

  var juggernaut = { 

    init : function(){ 
      this.socket = new Juggernaut; 
      this.offline = $("<div></div>")
    		.html("The connection has been disconnected! <br /> " + 
    		      "Please go back online to use this service.")
    		.dialog({
    			autoOpen: false,
    			modal:    true,
    			width:    330,
    			resizable: false,
    			closeOnEscape: false,
    			title: "Connection"
    		});
      this.socket.on("disconnect", this.proxy(this.disconnect));
      this.socket.subscribe('/ticketer',this.proxy(this.process));
      $('body').bind('ajaxSend', this.proxy(function(e, xhr){
          xhr.setRequestHeader('X-Session-ID', this.socket.sessionID);
      }));
    }, 

    disconnect: function(){
      this.offline.dialog("open");
    },

    process: function(data){

      placeId = $('#place_id').val(); 
      if(placeId && placeId == data.place){
        if(data.channel == "availables"){
          $.dataSlide('#tickets_available', {
                add : {
                  element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>'
                }
          });
         $.changeByOneValues( 'available', data.ticket_type_id, true);
        }else if (data.channel =="calleds"){ 
          callback(data);
        }
      }
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
    //If current_value has a NaN or undefined as value the condition should be false
    if (current_value != current_value) { 
      current_value = 0;
    }
    up ? $(tag).text(current_value + 1) : $(tag).text(current_value == 1 ? '' : current_value - 1);
  }

  window.juggernaut = juggernaut.init();
});
