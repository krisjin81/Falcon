jQuery(document).ready(function() {
	if (jQuery('.slide-carousel').length) {
		jQuery('.slide-carousel').slideCarousel ();
		jQuery('.slide-carousel').trigger('goto', 0);
	}
	if (jQuery('.color-switcher').length) {
		jQuery('.color-switcher').click(function () {
			var colorStylesheet = jQuery ('#colors-stylesheet'),
				chosenColor = jQuery(this).attr('id').substr(0, jQuery(this).attr('id').indexOf('-')),
				chosenCSS = colorStylesheet.attr('href').substr(0, colorStylesheet.attr('href').lastIndexOf('/')) + '/' + chosenColor + '.css';
			colorStylesheet.attr('href', chosenCSS);
		});
	}
});
$(document).ready(function() {
	// Declare variables
	var width = 364;
	var slides = $('#list-images li');
	var numSlides = slides.length;
	
	// Wrap the slides & set the wrap width - this will be used to animate the slider left/right
	slides.wrapAll('<div id="slide-wrap"></div>').css({'float' : 'left','width' : width});
	$('#slide-wrap').css({width: width * numSlides});
	
	$('#list-links li').click(function(){
	$('#list-links li').removeClass('active');
	var i = $(this).index('#list-links li');
	$(this).addClass('active');
	$('#slide-wrap').stop().animate({'marginLeft' : width*(-i)});
	});
	
	setInterval(function(){
		$('#carouselNext').trigger('click');
	},5000);
});
