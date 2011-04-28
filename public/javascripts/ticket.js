jQuery( document ).ready( function() {
  jQuery( 'a.generate' ).click( function() { 
    jQuery( '#ticket_ticket_type_id' ).val( this.id );
    param = jQuery( '#new_ticket' ).serialize();
    jQuery.ajax({
      url: "/senhas",
      type: "post",
      data: param,
      success: function(data){
        ticket = data.ticket;
        alert('Sua senha e: ' + ticket.value);
      }
      })
    } );
  jQuery('input#call_next').click( function() {
    jQuery.ajax({
        url: "chamar_proximo",
        type: "get",
        success: function(data){
          ticket = data.ticket;
          $("#tickets_called").append('<tr><td>'+ticket.value+'</td><td>'+ticket.updated_at+'</td></tr>');
          $('input#current').val(ticket.id);
        }
      })
    })
  jQuery('input#pending').click( function() {
    currentParameter = 'ticket_id='+$('input#current').val();
    jQuery.ajax({
        url: "por_em_espera",
        type: "put",
        data: currentParameter,
        success: function(data){
          ticket = data.ticket;
          $("#tickets_waiting").append('<tr><td>'+ticket.value+'</td><td>'+ticket.updated_at+'</td></tr>');
        }
      })
    })
  jQuery('input#recall').click( function() {
    currentParameter = 'ticket_id='+$('input#current').val();
    jQuery.ajax({
        url: "rechamar",
        type: "put",
        data: currentParameter,
      })
    })
   } )
