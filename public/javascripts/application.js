// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($) {
  $.clock = function() {
    $('.jclock').jclock();
  };
})($);

$(function(){
  $('input.date').datepicker({
                    autoSize : true,
                    dateFormat : 'yy-mm-dd',
                    changeYear : true,
                    changeMonth : true
  });
})
