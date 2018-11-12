import imports from './imports'

const subs = []

export const subscribeToChannels = () => {
  subs.push(imports())
}

export const unsubscribeFromChannels = () => {
  while (subs.length > 0) {
    const sub = subs.pop()

    sub.unsubscribe()
  }
}
