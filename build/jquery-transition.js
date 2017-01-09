(function() {
  (function(factory) {
    var root;
    root = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : void 0;
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      define(['jquery', 'exports'], function($) {
        return factory(root, document, $);
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(root, document, require('jquery'));
    } else {
      factory(root, document, root.$);
    }
  })(function(__root__, document, $) {
    var transitionEnd;
    transitionEnd = function() {
      var el, name, transEndEventNames;
      el = document.createElement('div');
      transEndEventNames = {
        WebkitTransition: 'webkitTransitionEnd',
        MozTransition: 'transitionend',
        OTransition: 'oTransitionEnd otransitionend',
        msTransition: 'MSTransitionEnd',
        transition: 'transitionend'
      };
      for (name in transEndEventNames) {
        if (el.style[name] != null) {
          return {
            end: transEndEventNames[name]
          };
        }
      }
      return false;
    };
    $.fn.emulateTransitionEnd = function(duration) {
      var $el, callback, called;
      called = false;
      $el = this;
      $el.one('transitionEnd', function() {
        called = true;
      });
      callback = function() {
        if (!called) {
          $el.trigger($.support.transition.end);
        }
      };
      setTimeout(callback, duration);
      return this;
    };
    $(function() {
      var handler;
      $.support.transition = transitionEnd();
      if ($.support.transition) {
        handler = function(e) {
          if (e.target === this) {
            e.handleObj.handler.apply(this, arguments);
          }
        };
        $.event.special.transitionEnd = {
          bindType: $.support.transition.end,
          delegateType: $.support.transition.end,
          handle: handler
        };
      }
    });
  });

}).call(this);
