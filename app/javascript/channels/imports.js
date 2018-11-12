import createChannel from './create-channel'
import { Notification } from '~/plugins/bootstrap-vue-utils'

const subscription = () => createChannel('imports', {
  completed: (data) => {
    Notification.success(data.message)
  },

  error: (data) => {
    Notification.error(data.error)
  }
})

export default subscription