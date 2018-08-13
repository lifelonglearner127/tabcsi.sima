import icons, { iconMap } from './icons'
import FaIcon from './icon'
import FaSprite from './sprite'
import forEach from 'lodash/forEach'
import { library } from '@fortawesome/fontawesome-svg-core'

const components = [FaIcon, FaSprite]

export { iconMap }

export default {
  install (Vue) {
    library.add(...icons)

    forEach(components, (component) => {
      Vue.component(component.name, component)
    })
  }
}
