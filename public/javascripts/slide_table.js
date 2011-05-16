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
 
  $.dataSlide = function(dataSlide, opts){

    if(opts.add) addElement(dataSlide, opts.add.element, opts.add.position)

  }


  /*
   * Private methods 
   */

   /*
   * This hook was created with intention of add dynamically new Intens to data slide.
   * Basic usage :
   *
   * $.dataSlide(".elementDataSlide", {
   *      add : {
   *        element : "<li> Here goes some new data </li>",
   *        position : 'top' //Default 'bottom'
   *      }
   *  })

   */

  function addElement( dataSlide, element, position){

    if(!(element || position)) return;
    
    container = $(dataSlide);
    pages = container.find('.swPage'); 
    wrapperData =  $(dataSlide).find('.swSlider');

    if(POSITION_TOP == position){ 
        
      first = pages.eq(0);
      first.prepend(element).attr('data-items', parseInt( first.attr('data-items') ) + 1);
      evaluatePages(wrapperData);
      
    }
    else{

      last = pages.eq(pages.length - 1);
      numberOfItems = parseInt( last.attr('data-items') );
      itemsPerPage = parseInt( last.attr('data-per-page') );

      if( numberOfItems  <  itemsPerPage  ){
        //Just add the new element to last page since has available space
        last.append(element).attr('data-items', numberOfItems + 1 );

      }
      else{

        pages = parseInt(wrapperData.attr('data-pages'));
        pageWidth =  last.width();

        addHipperLinksToContainer(container);

        //Add new page to container .swSlider
        newPage = createPage(itemsPerPage, pageWidth).prepend(element);
        newPage.attr("data-items", 1);
        addNewPageToContainer(wrapperData, newPage);
      }
    }
  }

  function evaluatePages(wrapperData){

    pages = wrapperData.find('.swPage');
    itemsPerPage = parseInt( pages.eq(0).attr('data-per-page') );

    $.each(pages, function(index, page) {
      page = $(page);
      numberOfItems = parseInt( page.attr('data-items') );
      if( numberOfItems > itemsPerPage ) {
        if(pages[index+1]){
          moveLastElementToNextPage(page, pages.eq(index+1)) 
        }else{
          newPage = createPage(itemsPerPage, page.width()); 
          moveLastElementToNextPage(page, newPage );
          addNewPageToContainer(wrapperData, newPage);
          addHipperLinksToContainer(wrapperData);
        }
      }
    });
  }

  function addNewPageToContainer(container, page){ 

    container.find('.clear').before(page);
    
    //Readjust width and the number of pages of the container .swSlider
    container.attr('data-pages', parseInt( container.attr('data-pages') )  + 1 );
    container.width(container.width() + page.width() );

  }

  function moveLastElementToNextPage(src, dest){
    liList = src.find("li");
    dest.append(liList.eq(liList.length - 1 ));
    src.attr('data-items', parseInt(src.attr('data-items')) - 1);
    dest.attr('data-items', parseInt(dest.attr('data-items')) + 1);
  }

  function createPage(itemsPerPage, pageWidth){
    page = $(document.createElement("div"));
    page.addClass("swPage");
    page.attr("data-items", "0");
    page.attr("data-per-page", itemsPerPage);
    page.css("float", "left");
    page.css("width", pageWidth);
    return page
  }

  function addHipperLinksToContainer(holder){
    //Add new href element to new page on container
    href = attachHiperLink(holder.parent().find('.swControls'), (parseInt( holder.attr('data-pages') ) + 1));
    href.click(function(event){
      eventSlid(this, event , holder.find('.swSlider'), holder);
    });
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

  $.fn.dataSlide = function(opts){
    
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

      //Calcs to facilitate to add new elements to data 
      restItems = ( numberOfItems - ( numberPerPage * i ) )
      items = restItems > numberPerPage ? numberPerPage : Math.abs( restItems ) ;  

      // Slice a portion of the lis, and wrap it in a swPage div:
      li.slice(start ,end).wrapAll('<div class="swPage" data-items='+ items +' data-per-page='+ numberPerPage+' />');
        
      // Adding a link to the swControls div:
      //swControls.append();

      attachHiperLink(swControls, i+1 ) 

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
      
      elem.find('li').each(function(){
          tmpHeight+=$(this).data('height');
      });

      if(tmpHeight>maxHeight)  maxHeight = tmpHeight;

      totalWidth+=elem.outerWidth();

      elem.css('float','left').width(ul.width());

    });
    
    swPage.wrapAll('<div class="swSlider" data-pages='+pagesNumber+'/>');
    
    // Setting the height of the ul to the height of the tallest page:
    ul.height(maxHeight);
    
    var swSlider = ul.find('.swSlider');

    swSlider.append('<div class="clear" />').width(totalWidth);

    var hyperLinks = ul.find('a.swShowPage');
    
    hyperLinks.click(function(event){
        eventSlid(this, event , swSlider, ul)
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

  //Private methods 
  
  function attachHiperLink(src, value,  target){
    href = document.createElement('a');
    $(href).addClass("swShowPage").prepend(value);

    if(! target)
      src.append( href );

    return $(href);
  }

  function eventSlid(element, event, swSlider, ul){
    
        // If one of the control links is clicked, slide the swSlider div 
        // (which contains all the pages) and mark it as active:
        $(element).addClass('active').siblings().removeClass('active');
        
        swSlider.stop().animate({'margin-left':-(parseInt($(element).text())-1)*ul.width()},'slow');
        event.preventDefault();

    }

 })(jQuery);


$(document).ready(function(){
  
  $('ul#tickets_available').dataSlide({numberPerPage:10, parent:"div#tickets_available"});
  $('ul#tickets_called').dataSlide({numberPerPage:10, parent:"div#tickets_called"});
  $('ul#tickets_waiting').dataSlide({numberPerPage:10, parent:"div#tickets_waiting"});
 
});
