jQuery(function($){

  var juggernaut = { 

    init : function(){ 
      this.socket = new Juggernaut; 
      this.socket.subscribe('/ticketer',this.proxy(this.process));
      $('body').bind('ajaxSend', this.proxy(function(e, xhr){
          xhr.setRequestHeader('X-Session-ID', this.socket.sessionID);
      }));
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
         this.changeByOneValues( data.ticket_type_id, true);
        }else if (data.channel =="calleds"){ 
          $.dataSlide('#tickets_available', { remove : 'li#'+data.id } );
          this.changeByOneValues( data.ticket_type_id, false); 
        }
      }
    }, 

    changeByOneValues: function(id, up){
      //Update value from top.
      size = $('ul#tickets_available.holder li').size();
      $('span#tickets_available_total').html('<i>Total: '+size+'</i>');
      
      //Update values from tag
      tag = 'ul#tickets_available_tag #ticket_type' + id;
      current_value = parseInt($(tag).text());
      up ? $(tag).text(current_value + 1) : $(tag).text(current_value - 1);
    },

    proxy: function(func){       
      var thisObject = this;
      return(function(){
        return func.apply(thisObject, arguments);
      });
    }
  };

  window.juggernaut = juggernaut.init();
});
