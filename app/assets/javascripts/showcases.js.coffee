##= require js-routes
##= require path
##= require styx
##= require jquery
##= require jquery_ujs
##= require jquery.ui.all
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#showcase_filter").bind 'change', () ->     
      id = $(this).val()
      $.ajax '/home/showcase_by_filter'
        type: 'GET'
        dataType: 'html'
        data: {"filter": id}
        success: (data, textStatus, jqXHR) ->   
          $("#showcase_box").html "#{data}" 
        