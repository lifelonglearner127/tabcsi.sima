import Component, { CORNER_TOP_RIGHT } from './component'
import createPopUpType from '../popup'
import filter from 'lodash/filter'
import forEach from 'lodash/forEach'

const ONE_REM_IN_PIXELS = 16

const setup = (instances, instance, options) => {
  let verticalOffset

  const corner = options.corner || CORNER_TOP_RIGHT

  verticalOffset = options.offset || 0

  forEach(filter(instances, ['corner', corner]), (inst) => {
    verticalOffset += inst.dom.offsetHeight + ONE_REM_IN_PIXELS
  })

  verticalOffset += ONE_REM_IN_PIXELS
  instance.verticalOffset = verticalOffset
}

const tearDown = (instances, instance, oldLength, index) => {
  let i

  if (oldLength <= 1) {
    return
  }

  const corner = instance.corner
  const removedHeight = instance.dom.offsetHeight

  for (i = index; i < oldLength - 1; ++i) {
    const inst = instances[i]

    if (inst.corner !== corner) {
      continue
    }

    const vertical = inst.cornerSides.vertical
    const newOffset = parseInt(inst.dom.style[vertical], 10) - removedHeight - ONE_REM_IN_PIXELS

    inst.dom.style[vertical] = `${newOffset}px`
  }
}

export default createPopUpType('notification', Component, setup, tearDown)
