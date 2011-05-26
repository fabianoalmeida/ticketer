(function(facebox) {

  facebox.fadeOutIn = function (time) {
    $('#facebox_overlay').unbind('click');
    $('#facebox').delay(time).fadeOut('slow', function() { $(document).trigger('close.facebox') })
  }

  facebox.new = function (data, klass) {
    facebox(data, klass);
    $('a.close').remove();
    return facebox;
  }

})(jQuery.facebox);
