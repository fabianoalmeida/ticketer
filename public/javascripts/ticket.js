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
      })
    } );
  jQuery('input#call_next').click( function() {
    jQuery.ajax({
        url: "chamar_proximo",
        type: "get",
        dataType: 'json',
        success: function(data){
          ticket = data.ticket;
          $("#tickets_called").append('<li><p>'+ticket.value+' '+ticket.updated_at+'</p></li>');
          $('input#current').val(ticket.id);
        }
      })
    })
  jQuery('input#pending').click( function() {
    currentParameter = 'ticket_id='+$('input#current').val();
    jQuery.ajax({
        url: "por_em_espera",
        type: "put",
        dataType: 'json',
        data: currentParameter,
        success: function(data){
          ticket = data.ticket;
          $("#tickets_waiting").append('<li><p>'+ticket.value+' '+ticket.updated_at+'</p></li>');
        }
      })
    })
  jQuery('input#recall').click( function() {
    currentParameter = 'ticket_id='+$('input#current').val();
    jQuery.ajax({
        url: "rechamar",
        type: "put",
        dataType: 'json',
        data: currentParameter
      })
    })
   } )
