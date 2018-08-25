import constant from 'lodash/constant'
import isFunction from 'lodash/isFunction'

// Polyfill for CustomEvent in IE9+.
// https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent/CustomEvent#Polyfill

((window) => {
  if (isFunction(window.CustomEvent)) {
    return
  }

  function CustomEvent (event, _params) {
    const params = _params || {
      bubbles: false,
      cancelable: false,
      detail: undefined
    }

    const evt = document.createEvent('CustomEvent')

    evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail)

    return evt
  }

  CustomEvent.prototype = window.Event.prototype

  // Fix setting `defaultPrevented` when `preventDefault()` is called.
  // http://stackoverflow.com/questions/23349191/event-preventdefault-is-not-working-in-ie-11-for-custom-events
  const { preventDefault } = CustomEvent.prototype

  CustomEvent.prototype.preventDefault = function preventDefaultFix () {
    const result = preventDefault.call(this)

    if (this.cancelable && !this.defaultPrevented) {
      Object.defineProperty(this, 'defaultPrevented', { get: constant(true) })
    }

    return result
  }

  window.CustomEvent = CustomEvent
})(window)
