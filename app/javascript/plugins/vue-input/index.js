import component from './component'

export default {
  install (Vue) {
    Vue.component(component.name, component)
  }
}
