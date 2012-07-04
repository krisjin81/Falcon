##= require jquery
##= require jquery_ujs
##= require jquery.ui.all
##= require jquery.blockUI
##= require bootstrap
##= require_tree ./accounts
##= require_tree ./affiliates

$ ->
  $('.datepicker').datepicker()

  $.extend($.blockUI.defaults.css, {
      backgroundColor: 'transparent',
      border: 'none',
      opacity: '0.4'
  });

  $.extend($.blockUI.defaults.overlayCSS, {
      backgroundColor: '#ccc',
      opacity: '0.4'
  });

  $.blockUI.defaults.message = '<img src="/assets/ajax-loader.gif" alt="Loading ..." />';

  $('a.fb-login').click (e) ->
    e.preventDefault()
    $.blockUI()
    link = $(this)
    FB.login((response) ->
      if (response && response.authResponse)
        $.ajax({
          url: link.attr('href'),
          method: 'POST',
          data: { signed_request: response.authResponse.signedRequest }
        })
      else
        $.unblockUI()
    ,{
      scope: link.data('scope')
    });