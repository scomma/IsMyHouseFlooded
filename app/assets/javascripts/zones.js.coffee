# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
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
      filter: if @value.length > 1 then ":contains(#{@value})" else '.significant'

  $('#sorter').show()
  $('#sorter a').click ->
    $('#zones').isotope
      sortBy: $(this).attr('href').slice(1)
      sortAscending: false
    false

  $('#zones').isotope
    itemSelector: '.zone'
    layoutMode: 'masonry'
    filter: '.significant'
    getSortData:
      time:  ($zone) -> $zone.data('time')
      count: ($zone) -> parseInt $zone.data('count')
      flood: ($zone) -> parseFloat $zone.data('flood')

  $('.zone h3 a, a.remote').each ->
    $(this).fancybox href: "#{@href}.partial"
