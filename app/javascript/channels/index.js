import imports from './imports'
import reports from './reports'

const subs = []

export const subscribeToChannels = () => {
  subs.push(imports())
  subs.push(reports())
}

export const unsubscribeFromChannels = () => {
  while (subs.length > 0) {
    const sub = subs.pop()

    sub.unsubscribe()
  }
}
