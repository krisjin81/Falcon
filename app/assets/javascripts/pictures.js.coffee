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
  $("#picture_filter").bind 'change', () ->     
      id = $(this).val()
      $.ajax '/home/picture_by_filter'
        type: 'GET'
        dataType: 'html'
        data: {"filter": id}
        success: (data, textStatus, jqXHR) ->   
          $("#picture_box").html "#{data}" 
        