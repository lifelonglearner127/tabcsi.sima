import csv from './csv'

const subs = []

export const subscribeToChannels = () => {
  subs.push(csv())
}

export const unsubscribeFromChannels = () => {
  while (subs.length > 0) {
    const sub = subs.pop()

    sub.unsubscribe()
  }
}
