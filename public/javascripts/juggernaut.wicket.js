function process(data) {
  placeId = $('#place_id').val(); 
  if(placeId && placeId == data.place){
    if(data.channel == "availables"){
      $.dataSlide('#tickets_available', {
            add : {
              element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>'
            }
      });
     $.changeByOneValues( 'available', data.ticket_type_id, true);

    } else if (data.channel == "calleds"){ 

      elemento = $('li#'+data.id);
      if (elemento.length > 0) {
         $.dataSlide('#tickets_available', { remove : 'li#'+data.id } );
         $.changeByOneValues( 'available', data.ticket_type_id, false); 
      }

    } else if (data.channel == "examed"){
      $.dataSlide('#tickets_available', {
            add : {
              element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>'
            }
      });
     $.changeByOneValues( 'available', data.ticket_type_id, true);
	}
  }
}
