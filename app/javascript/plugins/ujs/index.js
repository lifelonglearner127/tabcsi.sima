import directives from './directives'
import forEach from 'lodash/forEach'

export default {
  install (Vue) {
    forEach(directives, (directive) => {
      Vue.directive(directive.name, directive)
    })
  }
}
