# Taken from bootstrap: https://github.com/twbs/bootstrap/blob/master/js

transitionEnd = ->
  el = document.createElement('div')

  transEndEventNames =
    WebkitTransition: 'webkitTransitionEnd'
    MozTransition   : 'transitionend'
    OTransition     : 'oTransitionEnd otransitionend'
    msTransition    : 'MSTransitionEnd'
    transition      : 'transitionend'

  for name of transEndEventNames
    return end: transEndEventNames[name] if el.style[name]?

  false

# http://blog.alexmaccaw.com/css-transitions
$.fn.emulateTransitionEnd = (duration) ->
  called = false
  $el    = this
  $el.one 'transitionEnd', -> 
    called = true
    return

  callback = ->
    if not called
      $el.trigger($.support.transition.end)
    return

  setTimeout(callback, duration)
  this

$ ->
  $.support.transition = transitionEnd()

  if $.support.transition
    handler = (e) ->
      if e.target is this
        e.handleObj.handler.apply(this, arguments)
      return
      
    $.event.special.transitionEnd =
      bindType:     $.support.transition.end
      delegateType: $.support.transition.end
      handle:       handler
  return
