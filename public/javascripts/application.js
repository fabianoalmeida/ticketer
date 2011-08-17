// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($) {
  $.clock = function() {
    $('.jclock').jclock();
  };
})($);

$(function(){
  $.datepicker.setDefaults($.datepicker.regional['pt-BR']);

  var dates = $( "input.date.from,  input.date.to" ).datepicker({
      dateFormat : 'dd-mm-yy',
      showButtonPanel: true,
      autoSize : true,
      numberOfMonths: 2,
      onSelect: function( selectedDate ) {
	      var option = this.id == 'start_date' ? "minDate" : "maxDate",
		      instance = $( this ).data( "datepicker" ),
		      date = $.datepicker.parseDate(
			      instance.settings.dateFormat ||
			      $.datepicker._defaults.dateFormat,
			      selectedDate, instance.settings );
	      dates.not( this ).datepicker( "option", option, date );
      }
  });


})
