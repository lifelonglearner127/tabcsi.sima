import has from 'lodash/has'
import isObject from 'lodash/isObject'
import Vue from 'vue'

export const isServer = () => Vue.prototype.$isServer

export const isVNode = (node) => isObject(node) && has(node, 'componentOptions')
