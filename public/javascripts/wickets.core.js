jQuery( document ).ready( function() {
  jQuery( 'a.generate' ).click( function() { 
    jQuery( '#ticket_ticket_type_id' ).val( this.id );
    param = jQuery( '#new_ticket' ).serialize();
    jQuery.ajax({
      url: "/senhas",
      type: "post",
      data: param,
      dataType: 'json',
      success: function(data){
        ticket = data.ticket;
        jQuery.facebox( '<b>Senha:</b> ' + ticket.value + '<br/> <b>Data/Hora:</b> ' + ticket.created_at_formatted );
      }
    });
  });

  jQuery('a#call_next').jsonAjax({
      success : function(data){
          if ( data == null ) {
            jQuery.facebox.new( '<div style="text-align: center;">Não existem senhas a serem chamadas.</div>' ).fadeOutIn(3000);
          } else {
            $('input#current').val(data.ticket.id);

            jQuery.facebox.new( '<span style="color: red; font-weight: bold; font-size: 40px;">'+data.ticket.value+'</span><br/><br/><a id="attend" class="super button pink" data-url="atender" data-method="put">Atender</a>&nbsp;<a id="pending" class="super button pink" data-url="por_em_espera" data-method="put">Pendente</a>&nbsp<a id="recall" class="super button pink" data-url="rechamar" data-method="put">Rechamar</a>' ).afterCallNext();

            trigger();
          }
        }
    });

  function trigger() {

    jQuery( 'a#attend' ).click( function() { 
      param = 'ticket_id=' + jQuery( 'input#current' ).val();
      jQuery.ajax({
        url: "atender",
        type: "put",
        data: param,
        dataType: 'json',
        success: function(data){

          size = $('ul#tickets_available.holder li').size();
          $('span#tickets_available_total').html('<i>Total: '+size+'</i>');

          $.dataSlide('ul#tickets_attended', {
              add : {
                element : '<li id='+data.ticket.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.ticket.value+'</span> '+data.ticket.time+'</li>',
                position : 'top'
              }
            })

          size = $('ul#tickets_attended.holder li').size();
          $('span#tickets_attended_total').html('<i>Total: '+size+'</i>');

          $.changeByOneValues('attended', data.ticket.ticket_type_id, true);
          $.facebox.close();
        }
      });
    });

    jQuery( 'a#pending' ).click( function() { 
      param = 'ticket_id=' + jQuery( 'input#current' ).val();
      jQuery.ajax({
        url: "por_em_espera",
        type: "put",
        data: param,
        dataType: 'json',
        success: function(data){
          $.dataSlide('#tickets_called', { remove : 'li#'+data.ticket.id } );

          size = $('ul#tickets_called.holder li').size();
          $('span#tickets_called_total').html('<i>Total: '+size+'</i>');

          $.dataSlide('#tickets_waiting', {
              add : {
                element : '<li id='+data.ticket.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.ticket.value+'</span> '+data.ticket.time+'</li>',
                position : 'top'
              }
            })

         size = $('ul#tickets_waiting.holder li').size();
         $('span#tickets_waiting_total').html('<i>Total: '+size+'</i>');
         eventForLiPending();
         $.changeByOneValues('waiting', data.ticket.ticket_type_id, true);
         $.facebox.close();
        }
      });
    });
    jQuery('a#recall').jsonAjax({
        data : 'ticket_id='+$('input#current').val()
    });
  };

  function eventForLiPending(){

    jQuery("ul#tickets_waiting li").click(function(){
      size = $('ul#tickets_waiting.holder li').size();
      button_cancel = '<a id="cancel" class="super button pink" data-url="cancelar" data-method="get" style="margin : 10 px;">Cancelar</a>';
      button_reopen = '<a id="reopen" class="super button ajax pink" data-url="tornar_disponivel" data-method="get" style="margin : 10 px;">Disponibilizar</a>';
   
      buttons = button_cancel + '&nbsp;' + button_reopen ;
      jQuery.facebox.new(buttons);
      jQuery("#cancel").jsonAjax({
        method : 'delete', 
        data : 'ticket_id='+ this.id,
        success: function(data){
          $.facebox.close();
          $.dataSlide('#tickets_waiting', { remove : 'li#'+data.ticket.id } );
          $.changeByOneValues( 'waiting', data.ticket.ticket_type_id, false); 
        }
      });
      jQuery("#reopen").jsonAjax({
        method : 'put', 
        data : 'ticket_id='+ this.id,
        success: function(data){
          $.facebox.close();
          $.dataSlide('#tickets_waiting', { remove : 'li#'+data.ticket.id } );
          $.changeByOneValues( 'waiting', data.ticket.ticket_type_id, false); 
        }
      });
    });
  }

  eventForLiPending();
 })
