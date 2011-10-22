# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#new_report').hide()
  $('#initiate_report input:submit').click ->
    zone_id = parseInt $('#zone_id').val()
    if 10000 < zone_id < 100000
      $('#zone_id_label').text zone_id
      $('#report_zone_id').val zone_id
      $('#initiate_report').hide()
      $('#new_report').show()
    false

  $('#cancel_report').click ->
    $('#new_report').hide().get(0).reset()
    $('#initiate_report').show()

  $('#zone_id').keyup ->
    $('#zones').isotope
      filter: if @value.length then ":contains(#{@value})" else ""

  $('#zones').isotope
    itemSelector: '.zone'
    layoutMode: 'masonry'
