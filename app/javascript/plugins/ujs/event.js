export const fire = (obj, name, data) => {
  const event = new CustomEvent(name, {
    bubbles: true,
    cancelable: true,
    detail: data
  })

  obj.dispatchEvent(event)

  return !event.defaultPrevented
}

export const stopEverything = (e) => {
  fire(e.target, 'ujs:everythingStopped')
  e.preventDefault()
  e.stopPropagation()
  e.stopImmediatePropagation()
}
