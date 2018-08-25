import '../utils'
import Rails from '../rails'

const { stopEverything } = Rails

// Handles "data-method" on links such as:
// <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
Rails.handleMethod = function _handleMethod (e) {
  let formContent

  const method = this.getAttribute('data-method')

  if (!method) {
    return
  }

  const href = Rails.href(this)
  const csrfToken = Rails.csrfToken()
  const csrfParam = Rails.csrfParam()
  const form = document.createElement('form')

  formContent = `<input name='_method' value='${method}' type='hidden'>`
  if (!(csrfParam == null || csrfToken == null || Rails.isCrossDomain(href))) {
    formContent += `<input name='${csrfParam}' value='${csrfToken}' type='hidden'>`
  }

  // Must trigger submit by click on a button, else "submit" event handler won't work!
  // https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit
  formContent += '<input type="submit">'
  form.method = 'post'
  form.action = href
  form.target = this.target
  form.innerHTML = formContent
  form.style.display = 'none'

  document.body.appendChild(form)
  form.querySelector('[type="submit"]').click()
  stopEverything(e)
}
