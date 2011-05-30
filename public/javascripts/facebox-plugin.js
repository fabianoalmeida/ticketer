(function(facebox) {

  facebox.fadeOutIn = function (time) {
    $('#facebox').delay(time).fadeOut('slow', function() { $(document).trigger('close.facebox') })
  }

  facebox.afterCallNext = function () {
    $('#facebox').show().css({
      top: '300px'
    })
  }

  facebox.new = function (data, klass) {
    facebox(data, klass);
    $('a.close').remove();
    $('#facebox_overlay').unbind('click');
    return facebox;
  }

})(jQuery.facebox);

