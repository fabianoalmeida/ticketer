jQuery( document ).ready( function() {
  jQuery( 'a' ).click( function() { 
        if ( jQuery( '#ticket_ticket_type_id' ) != null ) {
          jQuery( '#ticket_ticket_type_id' ).val( this.id );
          jQuery( '#new_ticket' ).submit();
        }
        
        if ( jQuery( '#call_history_ticket_id' ) != null ) {
          jQuery( '#call_history_ticket_id' ).val( this.id );
          jQuery( '#new_call_history' ).submit();
        }
      } );
  } )
