import createChannel from './create-channel'
import { Notification } from '~/plugins/bootstrap-vue-utils'

const subscription = () => createChannel('reports', {
  completed: (data) => {
    Notification.success('Report generated.')
  }
})

export default subscription
