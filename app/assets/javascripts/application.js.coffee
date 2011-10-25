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

  $('a.remote').each ->
    $(this).fancybox
      href: "#{@href}.partial"
      onClosed: ->
        window.location.hash = '' if window.location.hash
        history.pushState '', document.title, window.location.pathname

  if window.location.hash
    $("a#{window.location.hash}.remote, #{window.location.hash} a.remote").first().trigger('click')
