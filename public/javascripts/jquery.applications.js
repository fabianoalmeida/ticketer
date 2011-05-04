(function($){

  $.fn.jsonAjax = function(options){
    
    var url = options.url ? options.url : this.attr("data-url");
    var method = options.method ? options.method : this.attr('data-method');
    var data = options.data ? options.data : '';
    var dataType = 'json';
    var success = options.success ? options.success : null ;
    var failure = options.failure ? options.failure : null ;
    
    $(this).click(function(){
        $.ajax({
            url : url,
            type : method,
            dataType : dataType,
            data : data, 
            success : success,
            error : failure
          });
      });
  }
})(jQuery)
