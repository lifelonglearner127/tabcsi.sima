import { csrfParam, csrfToken } from '../csrf'
import { isCrossDomain } from '../ajax'
import isEmpty from 'lodash/isEmpty'
import { stopEverything } from '../event'

const handleClick = function ujsMethodHandleClick (e) {
  let formContent

  const el = e.target
  const method = el.dataset.method

  if (!method) {
    return
  }

  const href = el.href
  const tokenName = csrfParam()
  const tokenValue = csrfToken()
  const form = document.createElement('form')

  formContent = `<input name="_method" value="${method}" type="hidden">`
  if (!(!tokenName || !tokenValue || isCrossDomain(href))) {
    formContent += `<input name="${tokenName}" value="${tokenValue}" type="hidden">`
  }

  // Must trigger submit by click on a button, else "submit" event handler won't work!
  // https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/submit
  formContent += '<input type="submit">'
  form.method = 'post'
  form.action = href
  form.target = el.target
  form.innerHTML = formContent
  form.style.display = 'none'

  document.body.appendChild(form)
  form.querySelector('[type="submit"]').click()
  stopEverything(e)
}

export default {
  name: 'UjsMethod',

  bind (el, binding) {
    const method = binding.value

    if (isEmpty(method)) {
      return
    }

    el.dataset.method = method

    el.addEventListener('click', handleClick)
  },

  unbind (el, binding) {
    if (isEmpty(binding.value)) {
      return
    }

    el.removeEventListener('click', handleClick)

    delete el.dataset.method
  }
}
