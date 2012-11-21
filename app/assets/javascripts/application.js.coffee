##= require js-routes
##= require path
##= require styx
##= require jquery
##= require jquery_ujs
##= require jquery.ui.all
##= require jquery.blockUI
##= require bootstrap 
##= require jquery-fileupload/basic
##= require_tree ./account
##= require_tree ./affiliate

$ ->
  $('.datepicker').datepicker()

  $.extend($.blockUI.defaults.css, {
      backgroundColor: 'transparent',
      border: 'none',
      opacity: '0.4'
  })

  $.extend($.blockUI.defaults.overlayCSS, {
      backgroundColor: '#ccc',
      opacity: '0.4'
  })

  $.blockUI.defaults.message = '<img src="/assets/ajax-loader.gif" alt="Loading ..." />'

  window.popup = (url, title, preferred_width, preferred_height) ->
    total_width = $(window).width()
    total_height = $(window).height()
    popup_width = Math.min(total_width - 20, preferred_width)
    popup_height = Math.min(total_height - 20, preferred_height)
    left_offset = (total_width - popup_width) / 2
    top_offset = (total_height - popup_height) / 2
    window.open(url, title, "width=#{popup_width},height=#{popup_height},left=#{left_offset},top=#{top_offset}")

  $('.share .fb-share').live 'click', (e) ->
    e.preventDefault()
    FB.ui(
      method: 'feed',
      link: window.location.href,
      name: $(this).data('name'),
      caption: $(this).data('caption'),
      description: $(this).data('description'),
      picture: $(this).data('image')
    )

  $('.share .twitter-share').live 'click', (e) ->
    e.preventDefault()
    window.popup($(this).attr('href'), $(this).attr('title'), 600, 300)

  $('.share .pinterest-share').live 'click', (e) ->
    e.preventDefault()
    window.popup($(this).attr('href'), $(this).attr('title'), 600, 300)

  $('a[disabled=disabled]').live 'click', (e) ->
    e.preventDefault()