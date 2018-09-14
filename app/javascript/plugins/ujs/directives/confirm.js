import { fire, stopEverything } from '../event'

const allowAction = (el) => {
  let answer, callback

  const message = el.dataset.confirm

  if (!message) {
    return true
  }

  answer = false
  if (fire(el, 'confirm')) {
    try {
      answer = window.confirm(message) // eslint-disable-line no-alert
    } catch (error) {
      // do nothing
    }

    callback = fire(el, 'confirm:complete', [answer])
  }

  return answer && callback
}

const handleClick = function ujsConfirmHandleClick (e) {
  if (!allowAction(e.target)) {
    stopEverything(e)
  }
}

export default {
  name: 'UjsConfirm',

  bind (el, binding) {
    el.dataset.confirm = binding.value

    el.addEventListener('click', handleClick)
  },

  unbind (el) {
    el.removeEventListener('click', handleClick)

    delete el.dataset.confirm
  }
}
