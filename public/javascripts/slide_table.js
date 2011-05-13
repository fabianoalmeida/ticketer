/**
 * This plugin provides a nice way to group any sort of data (images, text, forms, etc..) 
 * and navigate through them 
 *
 *
 * @author Vinícius Oliveira
 * @requires jQuery v1.4 or later
 * @version 0.1
 * */
(function($){
  
  var POSITION_TOP = 'top'
  var POSITION_BOTTOM = 'bottom'

  $.dataSlid = function(data, callback){

    if(! data.dataSlid )return 

    if(data.add) addElement(data.dataSlid, data.add.element, data.add.position)

  }

  /*
   * Private methods 
   */
  function addElement( dataSlid, element, position){
    if(!(element || position)) return;

    pages = $(dataSlid).find('.swPage'); 

    if(POSITION_BOTTOM == position){ 
    
    }
    else{
      last = pages[pages.length - 1];
      numberOfItems = $(last).attr('data-items');
      itemsByPage = $(last).attr('data-per-page');
      if(parseInt( numberOfItems ) <  parseInt ( itemsByPage ) ){
        $(last).append(element);
      }
      else{
        $(last).append(element);
      }
    }
  }

  /*
   * Default options & settings 
   */
  var settings = {
    numberPerPage : 5,
    heightContent : null, 
    widthContent : null, 
    heightContainer : null,
    containerWidth : null 
  }

  $.fn.dataSlid = function(opts){
    
    opts = opts || {};
    //Meging settings defautl with the passed by params
 

    var ul = this;
    var li = ul.find('li');
    var numberOfItems = li.length;
    var numberPerPage =  opts.numberPerPage ? opts.numberPerPage : settings.numberPerPage;

    // Given a list it will iterate over  
    li.each(function(){
    // Check if height of the content will be dynamic or was passed by settings
    var el = $(this);
    if(opts.heightContent){
    el.data('height', opts.heightContent); 
    }else {
    el.data('height',el.outerHeight(true));
    }
    });
    
    // Calculating the total number of pages:
    var pagesNumber = Math.ceil(li.length/numberPerPage);
    
    // If the pages are less than two, do nothing:
    if(pagesNumber<2) return this;

    /**
    * Creation of the controls div
    */
    var swControls = $('<div class="swControls">');
    
    //Add the efect slice to move from a page to another (THIS MIGHT BE GENERIC PASSED BY PARAMS )
    for(var i=0;i<pagesNumber;i++){
    
    start = ( i * numberPerPage );
    end = ( ( i + 1 ) * numberPerPage );

    //Calcs to facilitate adding new elements to data 
    restItems = ( numberOfItems - ( numberPerPage * i ) )
    items = restItems > numberPerPage ? numberPerPage : Math.abs( restItems ) ;  

    // Slice a portion of the lis, and wrap it in a swPage div:
    li.slice(start ,end).wrapAll('<div class="swPage" data-items='+ items +' data-per-page='+ numberPerPage+' />');
      
    // Adding a link to the swControls div:
    swControls.append('<a href="" class="swShowPage">'+(i+1)+'</a>');

    }

    //Append the control panel to div 
    ul.append(swControls);

    /**
    * Calculating and creating pages for the elements  
    */
    var maxHeight = 0;
    var totalWidth = 0;
    
    var swPage = ul.find('.swPage');

    swPage.each(function(){
        
        // Looping through all the newly created pages:
        var elem = $(this);
        var tmpHeight = 0;
        elem.find('li').each(function(){tmpHeight+=$(this).data('height');});
        if(tmpHeight>maxHeight)
                maxHeight = tmpHeight;
        totalWidth+=elem.outerWidth();
        elem.css('float','left').width(ul.width());

    });
    
    swPage.wrapAll('<div class="swSlider" data-pages='+pagesNumber+'/>');
    
    // Setting the height of the ul to the height of the tallest page:
    ul.height(maxHeight);
    
    var swSlider = ul.find('.swSlider');
    swSlider.append('<div class="clear" />').width(totalWidth);

    var hyperLinks = ul.find('a.swShowPage');
    
    hyperLinks.click(function(e){
        
        // If one of the control links is clicked, slide the swSlider div 
        // (which contains all the pages) and mark it as active:
        $(this).addClass('active').siblings().removeClass('active');
        
        swSlider.stop().animate({'margin-left':-(parseInt($(this).text())-1)*ul.width()},'slow');
        e.preventDefault();

    });
    
    // Mark the first link as active the first time this code runs:
    hyperLinks.eq(0).addClass('active');
    
    // Center the control div:
    swControls.css({
        'left':'50%',
        'margin-left':-swControls.width()/2
    });
    
    swControls.detach().appendTo(opts.parent);

    return this;
        
  }
 })(jQuery);


$(document).ready(function(){
  
  $('ul#tickets_available').dataSlid({numberPerPage:10, parent:"div#tickets_available"});
  $('ul#tickets_called').dataSlid({numberPerPage:10, parent:"div#tickets_called"});
  $('ul#tickets_waiting').dataSlid({numberPerPage:10, parent:"div#tickets_waiting"});
 
});
