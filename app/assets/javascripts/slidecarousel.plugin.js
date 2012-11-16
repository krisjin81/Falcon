$.fn.slideCarousel = function () {
	function repeat(str, num) {
        return new Array( num + 1 ).join( str );
    }
  
    return this.each(function () {
		$(this).addClass ('active');
        var $wrapper = $('> div', this),
            $slider = $wrapper.find('> ul'),
            $items = $slider.find('> li'),
            $single = $items.filter(':first'),
            
            singleWidth = $single.outerWidth(), 
            visible = Math.ceil($wrapper.innerWidth() / singleWidth),
            currentPage = 1,
            pages = Math.ceil($items.length / visible),
			linkWidth = Math.ceil( ($(window).width() - singleWidth) / 2);
			$wrapper.css('padding-left',linkWidth+'px');
			$wrapper.css('padding-right',linkWidth+'px');
			
        // 1. Pad so that 'visible' number will always be seen, otherwise create empty items
        if (($items.length % visible) != 0) {
            $slider.append(repeat('<li class="empty" />', visible - ($items.length % visible)));
            $items = $slider.find('> li');
        }

        // 2. Top and tail the list with 'visible' number of items, top has the last section, and tail has the first
        $items.filter(':first').before($items.slice(- visible).clone().addClass('cloned'));
        $items.filter(':last').after($items.slice(0, visible).clone().addClass('cloned'));
        $items = $slider.find('> li'); // reselect
        
        // 3. Set the left position to the first 'real' item
        $wrapper.scrollLeft(singleWidth * visible);
		
        
        // 4. paging function
        function gotoPage(page) {
            var dir = page < currentPage ? -1 : 1,
                n = Math.abs(currentPage - page),
                left = singleWidth * dir * visible * n;
            $wrapper.filter(':not(:animated)').animate({
                scrollLeft : '+=' + left
            }, 500, function () {
                if (page == 0) {
                    $wrapper.scrollLeft(singleWidth * visible * pages);
                    page = pages;
                } else if (page > pages) {
                    $wrapper.scrollLeft(singleWidth * visible);
                    // reset back to start position
                    page = 1;
                } 

                currentPage = page;
				$slider.find('li.active').removeClass('active');
				$slider.find('li:nth-child('+(page+1)+')').addClass ('active');
				$(".slide-carousel-btn").removeClass('active');
				$(".slide-carousel-btn"+currentPage).addClass('active');
            });                
            
            return false;
        }
        
		//$wrapper.find("<nav><a id='carouselPrevious' href='#'><b></b><span>Previous</span></a> <a id='carouselNext' href='#'><b></b><span>Next</span></a></nav>");
        
        // 5. Bind to the forward and back buttons
        $('a#carouselPrevious', this).click(function () {
            return gotoPage(currentPage - 1);                
        });
		$('a#carouselPrevious').css('width', linkWidth + 'px');
		//$('a#carouselPrevious b').css('background-position', (linkWidth - 65) + 'px center');
        
        $('a#carouselNext', this).click(function () {
            return gotoPage(currentPage + 1);
        });
		$('a#carouselNext').css('width', linkWidth + 'px');
        
        // create a public interface to move to a specific page
        $(this).bind('goto', function (event, page) {
            gotoPage(page);
        });
    });};
