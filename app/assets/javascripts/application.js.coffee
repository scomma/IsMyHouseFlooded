#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('input:text, input[type=number], textarea').uniform()
  $('input:submit, button').live 'mousedown', ->
    $(this).addClass 'clicked'
  $('input:submit, button').live 'mouseup', ->
    $(this).removeClass 'clicked'
  $('input:submit, button').live 'mouseout', ->
    $(this).removeClass 'clicked'
  $('.buttonset').buttonset()

  $('.zone h3 a, a.remote').each ->
    $(this).fancybox href: "#{@href}.partial"
