(function(window){
	
  window.process = function(data) {

    if(data.channel =="reload"){
      //Clean the last wicket that called the last ticket
      $('.highlight .last_ticket .infos').text(" -- ");
      //Clean the last Ticket called
      $('.highlight .label').text(" -- ");
      trList = $('tr.item');

      //Update current Date
      $('.current-date').html(data.current_date + " - ");

      trList.each(function() {
        tr = $(this);
        tr.children().remove()
        td_value = $("<td/>").text("--");
        td_wicket = $("<td/>").text("--");
        tr.append(td_value).append(td_wicket);
      });

    }else if (data.channel =="calleds"){

      //Replace the main infos ticket from view
      $('.highlight .last_ticket .infos').text(data.wicket_value );

      //Set new Ticket that has been called
      $('.highlight .label').text(data.value);

      var items = $('div.history_calls .item');

      //Add the new one ticket  to history
      new_item = $('<div/>').addClass("item").html(data.ticket_type_group + "<br/>" + data.value + " - " + data.wicket_value);
      tr = $("<tr/>").addClass("item");
      td_value = $("<td/>").text(data.value);
      td_wicket = $("<td/>").text(data.wicket_value.slice(0,9));
      tr.append(td_value).append(td_wicket);

      $('div.history_calls #first.items .label').after(tr);

      if($('div.history_calls #first.items table tr').size() == 5 ){
        last_tr_from_first = $('div.history_calls #first.items table tr').last().remove();
        $('div.history_calls #second.items .label').after(last_tr_from_first);
        if($('div.history_calls #second.items table tr').size() == 5){
          $('div.history_calls #second.items table tr').last().remove();
        }
      };

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
