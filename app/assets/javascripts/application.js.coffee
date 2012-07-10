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