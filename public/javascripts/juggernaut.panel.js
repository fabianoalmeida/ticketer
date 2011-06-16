(function(window){
  window.process = function(data) {
    if(data.channel =="calleds"){ 

      //Replace the main infos ticket from view 
      $('.highlight .last_ticket .infos').html(data.ticket_type_group + " &nbsp - &nbsp  " + data.ticket_type_value +"<br/>" + data.wicket_value );

      //Set new Ticket that has been called
      $('.highlight .label').text(data.value);

      var items = $('div.history_calls .item');

       //ensure maximum tickets to history are 9 (nine)  
      if(items.size() >= 7 ){
        items.last().remove();
      }

      //Add the new one ticket  to history
      new_item = $('<div/>').addClass("item").html(data.ticket_type_group + "<br/>" + data.value + " - " + data.wicket_value);
      $('div.history_calls .items').prepend(new_item);

      //Plays songs of notification
      $.playAudio("/audios/beep_alert.ogg");

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
