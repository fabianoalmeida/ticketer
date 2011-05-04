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

  jQuery('input#call_next').jsonAjax({
      success : function(data){
          ticket = data.ticket;
          $("#tickets_called").append('<li><p>'+ticket.value+' '+ticket.updated_at+'</p></li>');
          $('input#current').val(ticket.id);
        }
    });

  jQuery('input#pending').jsonAjax({ 
      data:'ticket_id='+$('input#current').val(), 
      success: function(data){
          ticket = data.ticket;
          $("#tickets_waiting").append('<li><p>'+ticket.value+' '+ticket.updated_at+'</p></li>');
        }
    });

  jQuery('input#recall').jsonAjax({
      data : 'ticket_id='+$('input#current').val()
    });
 })


//Ajax reverse Juggernaut with node.js to assync notification 

jQuery(document).ready(function(){

    var jugAvailables = new Juggernaut();
    jugAvailables.subscribe('availables', function(data){
        $("#tickets > ul").append('<li id='+data.id+'><p>'+data.value+' '+data.time+' </p></li>');
    }); 

    var jugCalled = new Juggernaut();
    jugCalled.subscribe('calleds', function(data){
        $("div#tickets > ul > li#"+data.id).remove();
    }); 
 }); 

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
