import '../utils'
import forEach from 'lodash/forEach'
import Rails from '../rails'

const { formElements, getData, matches, setData, stopEverything } = Rails

Rails.handleDisabledElement = function _handleDisabledElement (e) {
  if (this.disabled) {
    stopEverything(e)
  }
}

// Restore element to its original state which was disabled by 'disableLinkElement'
const enableLinkElement = (element) => {
  const originalText = getData(element, 'ujs:enable-with')

  if (originalText != null) {
    element.innerHTML = originalText // set to old enabled state

    setData(element, 'ujs:enable-with', null) // clean up cache
  }

  element.removeEventListener('click', stopEverything) // enable element

  setData(element, 'ujs:disabled', null)
}

const enableFormElement = (element) => {
  const originalText = getData(element, 'ujs:enable-with')

  if (originalText != null) {
    if (matches(element, 'button')) {
      element.innerHTML = originalText
    } else {
      element.value = originalText
    }

    setData(element, 'ujs:enable-with', null) // clean up cache
  }

  element.disabled = false

  setData(element, 'ujs:disabled', null)
}

// Re-enables disabled form elements:
//  - Replaces element text with cached value from 'ujs:enable-with' data store (created in `disableFormElements`)
//  - Sets disabled property to false
const enableFormElements = (form) => {
  forEach(formElements(form, Rails.formEnableSelector), enableFormElement)
}

// Unified function to enable an element (link, button and form)
Rails.enableElement = (e) => {
  const element = e instanceof Event ? e.target : e

  if (matches(element, Rails.linkDisableSelector)) {
    enableLinkElement(element)
  } else if (matches(element, Rails.buttonDisableSelector) || matches(element, Rails.formEnableSelector)) {
    enableFormElement(element)
  } else if (matches(element, Rails.formSubmitSelector)) {
    enableFormElements(element)
  }
}

//  Replace element's html with the 'data-disable-with' after storing original html
//  and prevent clicking on it
const disableLinkElement = (element) => {
  const replacement = element.getAttribute('data-disable-with')

  if (replacement != null) {
    setData(element, 'ujs:enable-with', element.innerHTML) // store enabled state

    element.innerHTML = replacement
  }

  element.addEventListener('click', stopEverything) // prevent further clicking

  setData(element, 'ujs:disabled', true)
}

const disableFormElement = (element) => {
  const replacement = element.getAttribute('data-disable-with')

  if (replacement != null) {
    if (matches(element, 'button')) {
      setData(element, 'ujs:enable-with', element.innerHTML)

      element.innerHTML = replacement
    } else {
      setData(element, 'ujs:enable-with', element.value)

      element.value = replacement
    }
  }

  element.disabled = true

  setData(element, 'ujs:disabled', true)
}

// Disables form elements:
//  - Caches element value in 'ujs:enable-with' data store
//  - Replaces element text with value of 'data-disable-with' attribute
//  - Sets disabled property to true
const disableFormElements = (form) => {
  forEach(formElements(form, Rails.formDisableSelector), disableFormElement)
}

// Unified function to disable an element (link, button and form)
Rails.disableElement = (e) => {
  const element = e instanceof Event ? e.target : e

  if (matches(element, Rails.linkDisableSelector)) {
    disableLinkElement(element)
  } else if (matches(element, Rails.buttonDisableSelector) || matches(element, Rails.formDisableSelector)) {
    disableFormElement(element)
  } else if (matches(element, Rails.formSubmitSelector)) {
    disableFormElements(element)
  }
}
