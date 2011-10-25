$ ->
  last_report = JSON.parse $.cookie 'last_report'
  hint_offered = false
  if last_report
    if (new Date()).getTime() - last_report.created_at > 54000000 # 15 hours have passed
      $('#report_zone_id').val last_report.zone_id
      $('.zone_id_label').text last_report.zone_id
      $('#new_report h2.main').hide()
      $('#new_report h2.hint').show()
      $('#initiate_report').hide()
      $('#new_report').show()
      hint_offered = true

  $('#initiate_report input:submit').click ->
    zone_id = parseInt $('#zone_id').val()
    if 10000 < zone_id < 100000
      $('.zone_id_label').text zone_id
      $('#report_zone_id').val zone_id
      $('#initiate_report').hide()
      $('#new_report').show()
    false

  $('#new_report input:submit').click ->
    flooded = $('#new_report input:radio:checked').val()
    if flooded
      $.cookie 'last_report', JSON.stringify
        zone_id: $('#report_zone_id').val()
        flooded: flooded
        created_at: (new Date()).getTime()

  $('#cancel_report').click ->
    $('#new_report').hide().get(0).reset()
    $('#initiate_report').show()
    console.log hint_offered
    if hint_offered
      $('#new_report h2.hint').hide()
      $('#new_report h2.main').show()
      $.cookie 'last_report', null
      hint_offered = false

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
