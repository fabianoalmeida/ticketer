(function($){

  var wicket ={

    init : function(){
      //Trigger Events Success for buttons
      this.triggers.fireAll();
      this.event_pending();
    },

    triggers : {

      fireAll : function(){
        this.call_next();
        this.pending();
        this.recall();
        this.attend();
        this.reopen();
        this.cancel();
        this.exam();
      },

      exam : function(){
	    
        if ( $('input#second_level').val() == "true" ) {
          
          $("ul#tickets_preexam li").css("cursor", "pointer");

	      $("ul#tickets_preexam li").click(function(){

	        size = $('ul#tickets_preexam.holder li').size();

	        button_examed = '<a id="examed" value='+this.id+' class="super button pink" style="margin : 10 px;">Examinado</a>';

	        $.facebox.new_with_close(button_examed).afterCallNext();

	        wicket.triggers.examed();
	      });
        }
      },

      examed : function(){
        $('a#examed').click(function(){
          $.ajax({
            url: "examinar",
            type: "put",
            data : {ticket_id : this.getAttribute('value') },
            dataType: 'json',
            success : function(data){
	
	           $.dataSlide('#tickets_preexam', { remove : 'li#'+data.id } );
	
               $.dataSlide('ul#tickets_examed', {
                   add : {
                     element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>',
                     position : 'top'
                   }
                 })

               $.changeByOneValues('examed', data.ticket_type_id, true);
               $.changeByOneValues('preexam', data.ticket_type_id, false);
               $.facebox.close();
             }
          });
        });
      },

      call_next : function(){

        $('a#call_next').click(function(){
          $.blockScreen();
        });

        $('a#call_next').bind('ajax:success', function(e, data, status, xhr) {
          $.displayScreen()
          if(xhr.status == 204) {
            $.facebox.new( '<div style="text-align: center;">Não existem senhas a serem chamadas.</div>' ).fadeOutIn(3000);
         } else {

            $('input#current').val(data.id);


            var button_attend = '<a id="attend" class="super button pink" >Atender</a>';
            var button_pending = '<a id="pending" class="super button pink">Pendente</a>';
            var button_cancel = '<a id="recall" class="super button pink">Rechamar</a>';

            //Refactor this
            $.facebox.new( '<span style="color: red; font-weight: bold; font-size: 40px;">'+data.value+'</span><br/><br/>'+button_attend+'&nbsp;'+button_pending+'&nbsp'+button_cancel).afterCallNext();

            //Trigger for buttons early created
            wicket.triggers.attend();
            wicket.triggers.pending();
            wicket.triggers.recall();
          }
        });
      },

      attend : function(){

        param = { ticket_id:  $( 'input#current' ).val() };

        $( 'a#attend' ).click( function() {
            param = 'ticket_id=' + $( 'input#current' ).val();
            $.ajax({
              url: "atender",
              type: "put",
              data: param,
              dataType: 'json',
              success: function(data){

                size = $('ul#tickets_available.holder li').size();
                $('span#tickets_available_total').html('<i>Total: '+size+'</i>');

                $.dataSlide('ul#tickets_attended', {
                    add : {
                      element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>',
                      position : 'top'
                    }
                  })

                size = $('ul#tickets_attended.holder li').size();
                $('span#tickets_attended_total').html('<i>Total: '+size+'</i>');

                $.changeByOneValues('attended', data.ticket_type_id, true);
                $.facebox.close();
              }
            });
          });

      },

      pending : function(){
        $( 'a#pending' ).click( function() {
          param = { ticket_id : $( 'input#current' ).val() } ;
          $.ajax({
            url: "por_em_espera",
            type: "put",
            data: param,
            dataType: 'json',
            success: function(data){
              $.dataSlide('#tickets_called', { remove : 'li#'+data.id } );

              size = $('ul#tickets_called.holder li').size();
              $('span#tickets_called_total').html('<i>Total: '+size+'</i>');

              $.dataSlide('#tickets_waiting',{
                  add : {
                    element : '<li id='+data.id+' style="width: 145px; text-align: center;"><span style="color: red;">'+data.value+'</span> '+data.time+'</li>',
                    position : 'top'
                  }
              });

              size = $('ul#tickets_waiting.holder li').size();
              $('span#tickets_waiting_total').html('<i>Total: '+size+'</i>');

              wicket.event_pending();

              $.changeByOneValues('waiting', data.ticket_type_id, true);
              $.facebox.close();
            }
          });
        });
      },

      recall :function(){
        $('a#recall').click(function(){
          param = { ticket_id : $( 'input#current' ).val() } ;
          $.ajax({
            url: "rechamar",
            type: "put",
            data: param,
            dataType: 'json'
          });
        });
      },

      cancel : function(){
        $('a#cancel').click(function(){
          $.ajax({
             url: "cancelar",
             type: "delete",
             data : {ticket_id : this.getAttribute('value') },
             dataType: 'json',
             success: function(data){
               $.facebox.close();
               $.dataSlide('#tickets_waiting', { remove : 'li#'+data.id } );
               $.changeByOneValues( 'waiting', data.ticket_type_id, false);
            }
          });
        });
      },

      reopen : function(){

        $('a#reopen').click(function(){

          $.ajax({
            url: "tornar_disponivel",
            type: "put",
            data : {ticket_id : this.getAttribute('value') },
            dataType: 'json',
            success : function(data){
               $.dataSlide('#tickets_waiting', { remove : 'li#'+data.id } );
               $.changeByOneValues( 'waiting', data.ticket_type_id, false);
               $.facebox.close();
             }
          });
        });
      }
    },

    event_pending : function(){

      $("ul#tickets_waiting li").click(function(){

        size = $('ul#tickets_waiting.holder li').size();

        button_cancel = '<a id="cancel" value='+this.id+' class="super button pink" style="margin : 10 px;">Cancelar</a>';
        button_reopen = '<a id="reopen" value='+this.id+' class="super button ajax pink" style="margin : 10 px;">Disponibilizar</a>';

        $.facebox.new_with_close(button_cancel + '&nbsp;' + button_reopen).afterCallNext();

        wicket.triggers.reopen();
        wicket.triggers.cancel();
      });
    }
  };

  window.wicket = wicket;
 })(jQuery);
