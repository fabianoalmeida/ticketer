/**
 * Menubox (for jQuery)
 * version: 0.1
 * @homepage http://github.com/vertocardoso/menubox
 * 
 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php  
 *
 * How to use
 *
 * $(document).ready(function(){ $('#link').menubox('#menuPopup') });
 *
 * <a href="#" id="link">show menu popup</a>
 * <div id="menuPopup">this is a menu popup</div>
 * Show the #menuPopup when click at #link.
 *
 */
(function($){
        $.fn.menubox = function(div) { 

          init(div);

          this.click(function() {  
            if ($(div).is(':visible')) hide($(div));
            else show($(div));
          }) 
	 // this.hover(function() {  
	 //        show($(div));
	 //       }, function(){
	 //       hide($(div));
         // })
        }

        /*
         * Private methods
         */
         function init(div) { 
           $(div).addClass("menubox");
           $(div).css({display: 'none'});
           $(div).css({overflow: 'visible', position: 'absolute', 'z-index': 100});
         }

         function show(div){
           $(div).fadeIn(500);
           showOverlay(div); 
         }

         function hide(div){
           $(div).hide();
           hideOverlay(); 
         }

         function showOverlay(div) { 
           if ($('#menu_overlay').length == 0) $("body").append('<div id="menu_overlay" style="position:fixed;top:0px;left:0px;height:100%;width:100%"></div>');
           $('#menu_overlay').click(function() { 
               	$(div).fadeOut(500); 
               	$("#menu_overlay").remove();
               })
         }

          function hideOverlay() { 
            $("#menu_overlay").remove();
          }

      })(jQuery);
