import Component, { DEFAULTS } from './component'
import { isServer, isVNode } from '../utils'
import assign from 'lodash/assign'
import ButtonProxy from './button-proxy'
import defer from 'lodash/defer'
import forOwn from 'lodash/forOwn'
import isFunction from 'lodash/isFunction'
import isPlainObject from 'lodash/isPlainObject'
import Vue from 'vue'

let currentMessage, instance

const MessageBoxConstructor = Vue.extend(Component)
const messageQueue = []

const defaultCallback = (button) => {
  if (!currentMessage) {
    return
  }

  const proxy = currentMessage.proxy

  try {
    if (instance.showInput) {
      proxy.callHandler(button, instance.inputValue)
    } else {
      proxy.callHandler(button)
    }
  } catch (err) {
    proxy.callHandler('error', err)
  }
}

const showNextMessage = () => {
  if (!instance) {
    instance = new MessageBoxConstructor({ el: document.createElement('div') })
    instance.callback = defaultCallback
  }

  instance.button = ''

  if ((instance.visible && !instance.closeTimer) || messageQueue.length <= 0) {
    return
  }

  currentMessage = messageQueue.shift()

  const options = currentMessage.options

  forOwn(options, (value, key) => {
    instance[key] = value
  })

  if (!isFunction(options.callback)) {
    instance.callback = defaultCallback
  }

  const oldCallback = instance.callback

  instance.callback = (button, inst) => {
    if (isFunction(oldCallback)) {
      oldCallback(button, inst)
    }

    showNextMessage()
  }

  if (isVNode(instance.message)) {
    instance.$slots.default = [instance.message]
    instance.message = null
  } else {
    delete instance.$slots.default
  }

  document.body.appendChild(instance.$el)

  Vue.nextTick(() => {
    instance.visible = true
  })
}

const getOptions = (...args) => {
  const [message, title, options = {}] = args

  // MessageBox(options)
  if (isPlainObject(message)) {
    return message
  }

  // MessageBox(message, options)
  if (isPlainObject(title)) {
    return assign({}, { message }, title)
  }

  // MessageBox(message)
  // MessageBox(message, title)
  // MessageBox(message, title, options)
  return assign(
    {},
    {
      message,
      title: title == null ? '' : title
    },
    options
  )
}

const MessageBox = (...args) => {
  if (isServer()) {
    return undefined
  }

  const options = getOptions(...args)
  const proxy = new ButtonProxy()
  const message = {
    options: assign({}, DEFAULTS, MessageBox.defaults, options),
    proxy
  }

  messageQueue.push(message)

  defer(showNextMessage)

  return proxy
}

MessageBox.setDefaults = (defaults) => {
  MessageBox.defaults = defaults
}

MessageBox.alert = (...args) => {
  const options = getOptions(...args)

  return MessageBox(assign({ type: 'alert' }, options))
}

MessageBox.confirm = (...args) => {
  const options = getOptions(...args)

  return MessageBox(assign(
    {
      type: 'confirm',
      buttons: 'yes-no',
      noButtonVariant: 'secondary',
      variant: 'warning',
      yesButtonVariant: 'danger'
    },
    options
  ))
}

MessageBox.prompt = (...args) => {
  const options = getOptions(...args)

  return MessageBox(assign(
    {
      type: 'prompt',
      buttons: 'ok-cancel',
      showInput: true
    },
    options
  ))
}

MessageBox.close = () => {
  instance.visible = false

  messageQueue.splice(0)

  currentMessage = null
}

export default MessageBox
