##= require jquery
##= require jquery_ujs
##= require jquery.ui.all
##= require bootstrap
##= require_tree ./admin

$ ->
  $('.datepicker').datepicker()
  $('.page-size select').bind 'change', () ->
    $(this).parent('form').submit()