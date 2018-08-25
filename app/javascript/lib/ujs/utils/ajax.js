import './csp'
import './csrf'
import './event'
import includes from 'lodash/includes'
import inRange from 'lodash/inRange'
import isFunction from 'lodash/isFunction'
import isString from 'lodash/isString'
import Rails from '../rails'

const SUCCESS_START = 200
const REDIRECT_START = 300

const { cspNonce, CSRFProtection } = Rails

const AcceptHeaders = {
  '*': '*/*',
  text: 'text/plain',
  html: 'text/html',
  xml: 'application/xml, text/xml',
  json: 'application/json, text/javascript',
  script: 'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript'
}

const prepareOptions = (options) => {
  options.url = options.url || location.href
  options.type = options.type.toUpperCase()

  // append data to url if it's a GET request
  if (options.type === 'GET' && options.data) {
    const sep = includes(options.url, '?') ? '&' : '?'

    options.url += `${sep}${options.data}`
  }

  if (AcceptHeaders[options.dataType] == null) {
    // Use "*" as default dataType
    options.dataType = '*'
  }

  options.accept = AcceptHeaders[options.dataType]
  if (options.dataType !== '*') {
    options.accept += ', */*; q=0.01'
  }

  return options
}

const createXHR = (options, done) => {
  const xhr = new XMLHttpRequest()

  // Open and setup xhr
  xhr.open(options.type, options.url, true)
  xhr.setRequestHeader('Accept', options.accept)

  // Set Content-Type only when sending a string
  // Sending FormData will automatically set Content-Type to multipart/form-data
  if (isString(options.data)) {
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
  }

  if (!options.crossDomain) {
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
  }

  // Add X-CSRF-Token
  CSRFProtection(xhr)

  xhr.withCredentials = Boolean(options.withCredentials)
  xhr.onreadystatechange = () => {
    if (xhr.readyState === XMLHttpRequest.DONE) {
      return done(xhr)
    }

    return undefined
  }

  return xhr
}

const processResponse = (_response, _type) => {
  let parser, response, type

  response = _response
  type = _type

  if (isString(response) && isString(type)) {
    if (type.match(/\bjson\b/)) {
      try {
        response = JSON.parse(response)
      } catch (error) {
        // do nothing
      }
    } else if (type.match(/\b(?:jav|ecm)ascript\b/)) {
      const script = document.createElement('script')

      script.setAttribute('nonce', cspNonce())
      script.text = response
      document.head.appendChild(script).parentNode.removeChild(script)
    } else if (type.match(/\bxml\b/)) {
      parser = new DOMParser()
      type = type.replace(/;.+/, '') // remove something like ';charset=utf-8'

      try {
        response = parser.parseFromString(response, type)
      } catch (error) {
        // do nothing
      }
    }
  }

  return response
}

Rails.ajax = (_options) => {
  const options = prepareOptions(_options)

  const xhr = createXHR(options, () => {
    const response = processResponse(
      xhr.response == null ? xhr.responseText : xhr.response,
      xhr.getResponseHeader('Content-Type')
    )

    if (inRange(xhr.status, SUCCESS_START, REDIRECT_START)) {
      if (isFunction(options.success)) {
        options.success(response, xhr.statusText, xhr)
      }
    } else if (isFunction(options.error)) {
      options.error(response, xhr.statusText, xhr)
    }

    return isFunction(options.complete) ? options.complete(xhr, xhr.statusText) : undefined
  })

  if (options.beforeSend != null && !options.beforeSend(xhr, options)) {
    return false
  }

  if (xhr.readyState === XMLHttpRequest.OPENED) {
    return xhr.send(options.data)
  }

  return undefined
}

// Default way to get an element's href. May be overridden at Rails.href.
Rails.href = (element) => element.href

// Determines if the request is a cross domain request.
Rails.isCrossDomain = (url) => {
  const originAnchor = document.createElement('a')
  const urlAnchor = document.createElement('a')

  originAnchor.href = location.href

  try {
    urlAnchor.href = url

    return ((urlAnchor.protocol && urlAnchor.protocol !== ':') || urlAnchor.host) &&
      `${originAnchor.protocol}//${originAnchor.host}` !== `${urlAnchor.protocol}//${urlAnchor.host}`
  } catch (error) {
    // If there is an error parsing the URL, assume it is crossDomain.
    return true
  }
}
