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

    /**
     * Variables to manipulate items and reorganize all of them
     */
    var numberOfItems = li.length;
    var numberPerPage =  opts.numberPerPage ? opts.numberPerPage : settings.numberPerPage;
    var pagesNumber = Math.ceil(li.length/numberPerPage);
       
    /**
    * Creation of the controls div
    */
    var swSlider = $('<div class="swSlider" data-pages='+ pagesNumber +'/>');
    var swControls = $('<div class="swControls">');
    
    //Add on the top .swSlider that is the wrapper for all elements into the <ul>
    ul.prepend(swSlider);
    
    if(pagesNumber == 0) {

      ul.append(createPage(numberPerPage, ul.height() )); 
      // Adding a link to the swControls div:
      attachHiperLink(swControls, 0 );

    }else {
      
      //Add the efect slice to move from a page to another (THIS MIGHT BE GENERIC PASSED BY PARAMS )
      for(var i=0;i<pagesNumber;i++){
      
        start = ( i * numberPerPage );
        end = ( ( i + 1 ) * numberPerPage );

        //Calcs to facilitate to add new elements to data 
        restItems = ( numberOfItems - ( numberPerPage * i ) )
        items = restItems > numberPerPage ? numberPerPage : Math.abs( restItems ) ;  

        // Slice a portion of the lis, and wrap it in a swPage div:
        li.slice(start ,end).wrapAll(createPage(numberPerPage,ul.outerWidth() , items ) );
          
        // Adding a link to the swControls div:
        attachHiperLink(swControls, i+1 ) 

      };
    };

    //Append the control panel to div to calculate the alignment to center
    ul.append(swControls);

    //Detach all pages to append to Container swSlider
    var swPage = ul.find('.swPage');
    swPage.detach().appendTo(swSlider);
    
    // Setting the height of the ul to the height of the tallest page:
    swSlider.append('<div class="clear" />').width(pagesNumber * ul.width());

    //Add events to hyperLinks
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
        
  };

   /* 
    * Private methods 
    * / 
 
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
   *
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

        addHipperLinksToContainer(container, wrapperData);

        //Add new page to container .swSlider
        newPage = createPage(itemsPerPage, pageWidth).prepend(element);
        newPage.attr("data-items", 1);
        addNewPageToContainer(wrapperData, newPage);
      }
    }
  };

  function evaluatePages(wrapperData){

    pages = wrapperData.find('.swPage');
    itemsPerPage = parseInt( pages.eq(0).attr('data-per-page') );

    pages.each(function(index, page) {
      page = $(page);
      numberOfItems = parseInt( page.attr('data-items') );
      if( numberOfItems > itemsPerPage ) {
        if(pages[index+1]){
          moveLastElementToNextPage(page, pages.eq(index+1)) 
        }else{
          newPage = createPage(itemsPerPage, page.width()); 
          moveLastElementToNextPage(page, newPage );
          addNewPageToContainer(wrapperData, newPage);
          addHipperLinksToContainer(wrapperData.parent(), wrapperData);
        }
      }
    });
  };

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

  function createPage(itemsPerPage, pageWidth, items){
    page = $("<div/>");
    
    //Default attributs and styles 
    page.addClass("swPage");
    page.attr("data-items", items || "0");
    page.attr("data-per-page", itemsPerPage);
    page.css("float", "left");
    page.css("width", pageWidth);

    return page
  }

  function addHipperLinksToContainer(container, holder){

    //Add new href element to new page on container
    href = attachHiperLink(container.parent().find('.swControls'), (parseInt( holder.attr('data-pages') ) + 1));
    href.click(function(event){
      eventSlid(this, event , holder.find('.swSlider'), container);
    });

  }
 
  function attachHiperLink(src, value,  target){
    href = $("<a/>");
    href.addClass("swShowPage").prepend(value);

    if(! target)
      src.append( href );

    return href;
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
