(function(window){
  window.process = function(data) {
    if(data.channel =="calleds"){ 
      //Replace the main ticket from view 
      $('div.last_ticket').html('<div style="font-size:30px; color : black; margin : 20px 0;">Guichê: '+data.wicket_value+'<br/>Tipo: '+data.ticket_type_value+'</div>'+data.value);

      var items = $('div.history_calls .item');

       //ensure maximum tickets to history are 9 (nine)  
      if(items.size() >= 9 ){
        items.last().remove();
      }

      //Add the new one ticket  to history
      $('div.history_calls .label').after('<div class="item"><div class="botton">'+data.time+'</div><div class="content">'+data.value+'</div>');

      //Plays songs of notification
      $.playAudio("/audios/beep_alert.mp3");

      //Display the orientation for  the wicket that call the ticket.
      if(data.left){ 
        jQuery('img#image_left').show();
        jQuery('img#image_right').hide();
      }

      if(data.right){ 
        jQuery('img#image_right').show();
        jQuery('img#image_left').hide();
      }
    }
  }
})(window)
