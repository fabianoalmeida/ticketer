function process(data) {
  ticket_type_group_id = data.ticket_type_group_id;
  placeId  = $('#place_id').val();
  groupIds = $('#ticket_type_groups').val();
  if(placeId && (placeId == data.place || placeId == data.place_slug)
			 && groupIds.indexOf(ticket_type_group_id) != -1){
    if(data.channel == "availables"){
      $.dataSlide('#tickets_available', {
            add : {
              element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>'
            }
      });
      $.changeByOneValues( 'available', data.ticket_type_id, true);
      wicket.triggers.call_ticket();

    } else if (data.channel == "calleds"){

      elemento = $('li#'+data.id);
      if (elemento.length > 0) {
         $.dataSlide('#tickets_available', { remove : 'li#'+data.id } );
         $.changeByOneValues( 'available', data.ticket_type_id, false);
      }

    } else if (data.channel == "attendeds"){

      $.dataSlide('#tickets_preexam', {
            add : {
              element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>'
            }
      });
      $.changeByOneValues( 'preexam', data.ticket_type_id, true);
  	  wicket.triggers.exam();

    } else if (data.channel == "exameds"){

      elemento = $('li#'+data.id);
      if (elemento.length > 0) {
         $.dataSlide('#tickets_attended', { remove : 'li#'+data.id } );
         $.changeByOneValues( 'attended', data.ticket_type_id, false);
      }
  	}
  }
}
