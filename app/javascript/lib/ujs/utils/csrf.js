import './dom'
import forEach from 'lodash/forEach'
import Rails from '../rails'

const { $ } = Rails

// Up-to-date Cross-Site Request Forgery token
const csrfToken = Rails.csrfToken = () => {
  const meta = document.querySelector('meta[name=csrf-token]')

  return meta && meta.content
}

// URL param that must contain the CSRF token
const csrfParam = Rails.csrfParam = () => {
  const meta = document.querySelector('meta[name=csrf-param]')

  return meta && meta.content
}

// Make sure that every Ajax request sends the CSRF token
Rails.CSRFProtection = (xhr) => {
  const token = csrfToken()

  if (token != null) {
    xhr.setRequestHeader('X-CSRF-Token', token)
  }
}

// Make sure that all forms have actual up-to-date tokens (cached forms contain old ones)
Rails.refreshCSRFTokens = () => {
  const token = csrfToken()
  const param = csrfParam()

  if (token != null && param != null) {
    forEach($(`form input[name="${param}"]`), (input) => {
      input.value = token
    })
  }
}
