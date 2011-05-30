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
            jQuery.facebox.new( '<div style="text-align: center;">Não existem senhas para serem chamadas.</div>' ).fadeOutIn(3000);
          } else {
            $('input#current').val(data.ticket.id);

            jQuery.facebox.new( data.ticket.value+'<a id="attend" class="super button pink" data-url="atender" data-method="put">Atender</a><a id="pending" class="super button pink" data-url="por_em_espera" data-method="put">Pendente</a><a id="recall" class="super button pink" data-url="rechamar" data-method="put">Rechamar</a>' ).afterCallNext();

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

          $.changeByOneValues('waiting', data.ticket.ticket_type_id, true);
          $.facebox.close();
        }
      });
    });

    jQuery('a#recall').jsonAjax({
        data : 'ticket_id='+$('input#current').val()
      });
  }

 })

//Order and pagination table
jQuery(document).ready(function(){
  jQuery('#tickets').pajinate({
      num_page_links_to_display : 4,
      nav_label_first : ' << ',
      nav_label_last : ' >> ',
      nav_label_prev : ' < ',
      nav_label_next : ' > ',
      nav_panel_id : '.page_nav'
  });

  jQuery('#tickets_waiting').pajinate({
      num_page_links_to_display : 4,
      nav_label_first : ' << ',
      nav_label_last : ' >> ',
      nav_label_prev : ' < ',
      nav_label_next : ' > ',
      nav_panel_id : '.page_nav'
  });


  jQuery('#tickets_called').pajinate({
      num_page_links_to_display : 4,
      nav_label_first : ' << ',
      nav_label_last : ' >> ',
      nav_label_prev : ' < ',
      nav_label_next : ' > ',
      nav_panel_id : '.page_nav'
  });
});
