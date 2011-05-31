function process(data) {
  if(data.channel =="calleds"){ 
    $('div.last_ticket').html('<div style="font-size:30px; color : black; margin : 20px 0;">Guichê: '+data.wicket_value+'<br/>Tipo: '+data.ticket_type_value+'</div>'+data.value);
   var items = $('div.history_calls .item');
   items.last().remove();
   items.stop().animate({left: items.width()}, 'slow');
   $('div.history_calls .label').after('<div class="item"><div class="botton">'+data.time+'</div><div class="content">'+data.value+'</div>');
   jQuery('audio')[0].play();

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
