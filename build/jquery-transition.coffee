((factory) ->

  # Browser and WebWorker
  root = if typeof self is 'object' and self isnt null and self.self is self
    self

  # Server
  else if typeof global is 'object' and global isnt null and global.global is global
    global

  # AMD
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery', 'exports'], ($) ->
      factory(root, document, $)

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    factory(root, document, require('jquery'))

  # Browser and the rest
  else
    factory(root, document, root.$)

  # No return value
  return

)((__root__, document, $) ->
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
  # No global variable export
  return
)