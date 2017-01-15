###!
# jquery-transition-support 1.0.2 | https://github.com/yivo/jquery-transition-support | MIT License
###

((factory) ->

  __root__ = 
    # The root object for Browser or Web Worker
    if typeof self is 'object' and self isnt null and self.self is self
      self

    # The root object for Server-side JavaScript Runtime
    else if typeof global is 'object' and global isnt null and global.global is global
      global

    else
      Function('return this')()

  # Asynchronous Module Definition (AMD)
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery'], ($) ->
      factory(__root__, document, setTimeout, $)

  # Server-side JavaScript Runtime compatible with CommonJS Module Spec
  else if typeof module is 'object' and module isnt null and typeof module.exports is 'object' and module.exports isnt null
    factory(__root__, document, setTimeout, require('jquery'))

  # Browser, Web Worker and the rest
  else
    factory(__root__, document, setTimeout, $)

  # No return value
  return

)((__root__, document, setTimeout, $) ->
  # Credits to:
  #  * bootstrap CSS framework: https://github.com/twbs/bootstrap
  #  * blog.alexmaccaw.com:     http://blog.alexmaccaw.com/css-transitions
  
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
  # Nothing exported
  return
)