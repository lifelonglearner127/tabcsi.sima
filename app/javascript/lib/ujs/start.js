import forEach from 'lodash/forEach'
import Rails from './rails'

const NORMAL_SUBMIT_TIMEOUT = 13

const {
  $, delegate, disableElement, enableElement, formSubmitButtonClick, getData, handleConfirm, handleDisabledElement,
  handleMetaClick, handleMethod, handleRemote, refreshCSRFTokens
} = Rails

const delegateEvents = () => {
  delegate(document, Rails.linkDisableSelector, 'ajax:complete', enableElement)   // enable
  delegate(document, Rails.linkDisableSelector, 'ajax:stopped', enableElement)    // enable
  delegate(document, Rails.buttonDisableSelector, 'ajax:complete', enableElement) // enable
  delegate(document, Rails.buttonDisableSelector, 'ajax:stopped', enableElement)  // enable
  delegate(document, Rails.linkClickSelector, 'click', handleDisabledElement)     // disabled
  delegate(document, Rails.linkClickSelector, 'click', handleConfirm)
  delegate(document, Rails.linkClickSelector, 'click', handleMetaClick)           // meta
  delegate(document, Rails.linkClickSelector, 'click', disableElement)            // disable
  delegate(document, Rails.linkClickSelector, 'click', handleRemote)              // remote
  delegate(document, Rails.linkClickSelector, 'click', handleMethod)
  delegate(document, Rails.buttonClickSelector, 'click', handleDisabledElement)   // disabled
  delegate(document, Rails.buttonClickSelector, 'click', handleConfirm)
  delegate(document, Rails.buttonClickSelector, 'click', disableElement)          // disable
  delegate(document, Rails.buttonClickSelector, 'click', handleRemote)            // remote
  delegate(document, Rails.inputChangeSelector, 'change', handleDisabledElement)  // disabled
  delegate(document, Rails.inputChangeSelector, 'change', handleConfirm)
  delegate(document, Rails.inputChangeSelector, 'change', handleRemote)           // remote
  delegate(document, Rails.formSubmitSelector, 'submit', handleDisabledElement)   // disabled
  delegate(document, Rails.formSubmitSelector, 'submit', handleConfirm)
  delegate(document, Rails.formSubmitSelector, 'submit', handleRemote)            // remote

  // Normal mode submit; slight timeout so that the submit button gets properly serialized
  delegate(
    document, Rails.formSubmitSelector, 'submit', (e) => setTimeout(() => disableElement(e), NORMAL_SUBMIT_TIMEOUT)
  )

  delegate(document, Rails.formSubmitSelector, 'ajax:send', disableElement)        // disable
  delegate(document, Rails.formSubmitSelector, 'ajax:complete', enableElement)     // enable
  delegate(document, Rails.formInputClickSelector, 'click', handleDisabledElement) // disabled
  delegate(document, Rails.formInputClickSelector, 'click', handleConfirm)
  delegate(document, Rails.formInputClickSelector, 'click', formSubmitButtonClick) // submit
}

Rails.start = () => {
  if (window._rails_loaded) {
    // Cut down on the number of issues from people inadvertently including rails-ujs twice by detecting and raising an
    // error when it happens.
    throw new Error('rails-ujs has already been loaded!')
  }

  // This event works the same as the load event, except that it fires every time the page is loaded.
  // See https://github.com/rails/jquery-ujs/issues/357
  // See https://developer.mozilla.org/en-US/docs/Using_Firefox_1.5_caching
  window.addEventListener('pageshow', () => {
    forEach($(Rails.formEnableSelector), (el) => {
      if (getData(el, 'ujs:disabled')) {
        enableElement(el)
      }
    })

    forEach($(Rails.linkDisableSelector), (el) => {
      if (getData(el, 'ujs:disabled')) {
        enableElement(el)
      }
    })
  })

  delegateEvents()
  refreshCSRFTokens() // formerly, DOMContentLoaded event handler

  window._rails_loaded = true
}
