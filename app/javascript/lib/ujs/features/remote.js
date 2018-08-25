import '../utils'
import Rails from '../rails'

const { ajax, fire, getData, isCrossDomain, matches, serializeElement, setData, stopEverything } = Rails

// Checks "data-remote" if true to handle the request through a XHR request.
const isRemote = (element) => {
  const value = element.getAttribute('data-remote')

  return !(value == null || value === 'false')
}

const formSubmitOptions = (form) => {
  let data, url

  // memoized value from clicked submit button
  const button = getData(form, 'ujs:submit-button')
  const method = getData(form, 'ujs:submit-button-formmethod') || form.method

  url = getData(form, 'ujs:submit-button-formaction') || form.getAttribute('action') || location.href

  if (method.toUpperCase() === 'GET') {
    // strip query string if it's a GET request
    url = url.replace(/\?.*$/, '')
  }

  if (form.enctype === 'multipart/form-data') {
    data = new FormData(form)
    if (button != null) {
      data.append(button.name, button.value)
    }
  } else {
    data = serializeElement(form, button)
  }

  setData(form, 'ujs:submit-button', null)
  setData(form, 'ujs:submit-button-formmethod', null)
  setData(form, 'ujs:submit-button-formaction', null)

  return [data, method, url]
}

// Submits "remote" forms and links with ajax
Rails.handleRemote = function _handleRemote (e) {
  let data, method, url

  if (!isRemote(this)) {
    return true
  }

  if (!fire(this, 'ajax:before')) {
    fire(this, 'ajax:stopped')

    return false
  }

  const withCredentials = this.getAttribute('data-with-credentials')
  const dataType = this.getAttribute('data-type') || 'script'

  if (matches(this, Rails.formSubmitSelector)) {
    [data, method, url] = formSubmitOptions(this)
  } else if (matches(this, Rails.buttonClickSelector) || matches(this, Rails.inputChangeSelector)) {
    method = this.getAttribute('data-method')
    url = this.getAttribute('data-url')
    data = serializeElement(this, this.getAttribute('data-params'))
  } else {
    method = this.getAttribute('data-method')
    url = Rails.href(this)
    data = this.getAttribute('data-params')
  }

  ajax({
    type: method || 'GET',
    url,
    data,
    dataType,

    // stopping the "ajax:beforeSend" event will cancel the ajax request
    beforeSend: (xhr, options) => {
      if (fire(this, 'ajax:beforeSend', [xhr, options])) {
        return fire(this, 'ajax:send', [xhr])
      }

      fire(this, 'ajax:stopped')

      return false
    },

    success: (...args) => fire(this, 'ajax:success', args),
    error: (...args) => fire(this, 'ajax:error', args),
    complete: (...args) => fire(this, 'ajax:complete', args),

    crossDomain: isCrossDomain(url),
    withCredentials: !(withCredentials == null && withCredentials === 'false')
  })

  stopEverything(e)

  return undefined
}

Rails.formSubmitButtonClick = function _formSubmitButtonClick (e) {
  const form = this.form

  if (!form) {
    return
  }

  if (this.name) {
    // Register the pressed submit button
    setData(form, 'ujs:submit-button', {
      name: this.name,
      value: this.value
    })
  }

  // Save attributes from button
  setData(form, 'ujs:formnovalidate-button', this.formNoValidate)
  setData(form, 'ujs:submit-button-formaction', this.getAttribute('formaction'))
  setData(form, 'ujs:submit-button-formmethod', this.getAttribute('formmethod'))
}

Rails.handleMetaClick = function _handleMetaClick (e) {
  const method = (this.getAttribute('data-method') || 'GET').toUpperCase()
  const data = this.getAttribute('data-params')
  const metaClick = e.metaKey || e.ctrlKey

  if (metaClick && method === 'GET' && !data) {
    e.stopImmediatePropagation()
  }
}
