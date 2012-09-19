(function(facebox) {

  facebox.fadeOutIn = function (time) {
    $('#facebox').delay(time).fadeOut('slow', function() { $(document).trigger('close.facebox') })
  }

  facebox.afterCallNext = function () {
    $('#facebox .content').css({
      width: '515px'
    })
    $('#facebox').css({
        left:	$(window).width() / 2 - ($('#facebox .popup').outerWidth() / 2),
        textAlign: 'center'
    })
  }

  facebox.new = function (data, klass) {
    facebox(data, klass);
    $('a.close').hide();
    $('#facebox_overlay').unbind('click');
    return facebox;
  }

  facebox.new_with_close = function (data, klass) {
    facebox(data, klass);
    $('a.close').show();
    $('#facebox_overlay').unbind('click');
    return facebox;
  }
})(jQuery.facebox);

