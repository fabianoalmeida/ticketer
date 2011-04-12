jQuery( document ).ready( function() {
  jQuery( 'a' ).click( function() { 
        jQuery( '#ticket_ticket_type' ).val( this.id );
        jQuery( '#new_ticket' ).submit();
      } );
  
  jQuery( 'select' ).change( function() { 
        jQuery( '#new_ticket' ).submit();
      } );
  } )
