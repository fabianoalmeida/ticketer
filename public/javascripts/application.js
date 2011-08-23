// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($) {
  $.clock = function() {
    $('.jclock').jclock();
  };

  $.blockScreen = function(){
    $('.screen_overlay').show();
  }

  $.displayScreen = function(){
    $('.screen_overlay').hide();
  }
  
})($);

