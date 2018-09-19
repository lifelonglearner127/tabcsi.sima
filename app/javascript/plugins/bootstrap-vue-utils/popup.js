import { isServer, isVNode } from './utils'
import { TYPE_VARIANT_MAP, TYPES } from './variants'
import assign from 'lodash/assign'
import forEach from 'lodash/forEach'
import forEachRight from 'lodash/forEachRight'
import isFunction from 'lodash/isFunction'
import isString from 'lodash/isString'
import Vue from 'vue'

let zIndex

const Z_INDEX_BASE = 2000

zIndex = Z_INDEX_BASE

const getOptions = (_options) => {
  let options

  options = _options || {}
  if (isString(options) || isVNode(options)) {
    options = { message: options }
  }

  return options
}

const nextZIndex = () => zIndex++

export default (popUpType, component, setup, tearDown) => {
  let instance, seed

  const Constructor = Vue.extend(component)
  const instances = []

  seed = 1

  const PopUp = (_options) => {
    if (isServer()) {
      return undefined
    }

    const options = getOptions(_options)

    const userOnClose = options.onClose
    const id = `${popUpType}_${seed++}`

    options.onClose = () => {
      PopUp.close(id, userOnClose)
    }

    instance = new Constructor({ data: assign({}, options) })
    instance.id = id

    if (isVNode(instance.message)) {
      instance.$slots.default = [instance.message]
      instance.message = null
    }

    instance.vm = instance.$mount()

    document.body.appendChild(instance.vm.$el)

    instance.vm.visible = true
    instance.dom = instance.vm.$el
    instance.dom.style.zIndex = nextZIndex()

    if (isFunction(setup)) {
      setup(instances, instance, options)
    }

    instances.push(instance)

    return instance.vm
  }

  forEach(TYPES, (type) => {
    PopUp[type] = (_options) => {
      const options = getOptions(_options)

      options.variant = TYPE_VARIANT_MAP[type]

      return PopUp(options)
    }
  })

  PopUp.close = (id, userOnClose) => {
    const oldLength = instances.length

    forEach(instances, (inst, index) => {
      if (inst.id !== id) {
        return undefined // continue
      }

      if (isFunction(userOnClose)) {
        userOnClose(inst)
      }

      instances.splice(index, 1)

      if (isFunction(tearDown)) {
        tearDown(instances, inst, oldLength, index)
      }

      return false // break
    })
  }

  PopUp.closeAll = () => {
    forEachRight(instances, (inst) => {
      inst.close()
    })
  }

  return PopUp
}
