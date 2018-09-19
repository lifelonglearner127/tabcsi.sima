import assign from 'lodash/assign'
import Message from './message'
import MessageBox from './message-box'
import Notification from './notification'

export default {
  install (Vue) {
    assign(Vue.prototype, {
      // $msgbox: MessageBox,
      $alert: MessageBox.alert,
      $confirm: MessageBox.confirm,
      $prompt: MessageBox.prompt,
      $notify: Notification,
      $message: Message
    })
  }
}

export {
  Message,
  MessageBox,
  Notification
}
