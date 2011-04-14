jQuery( document ).ready( function() {
  jQuery( 'a' ).click( function() { 
        jQuery( '#ticket_ticket_type_id' ).val( this.id );
        jQuery( '#new_ticket' ).submit();
      } );
