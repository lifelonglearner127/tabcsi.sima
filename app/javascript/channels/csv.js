import createChannel from './create-channel'

const subscription = () => createChannel('csv', {
  update: (data) => { // eslint-disable-line lodash/prefer-noop
    // do something
  },

  completed: (data) => { // eslint-disable-line lodash/prefer-noop
    // do something
  },

  error: (data) => { // eslint-disable-line lodash/prefer-noop
    // do something
  }
})

export default subscription
