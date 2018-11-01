import createChannel from './create-channel'
import { Notification } from '~/plugins/bootstrap-vue-utils'

const subscription = () => createChannel('csv', {
  completed: (data) => {
    Notification.success(data.body)
  },

  error: (data) => {
    Notification.error(data.body)
  }
})

export default subscription
