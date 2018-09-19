import { buildIconMap } from './icon-map'
import FaIcon from './icon'
import FaSprite from './sprite'
import FaSprites from './sprites'
import forEach from 'lodash/forEach'
import { library } from '@fortawesome/fontawesome-svg-core'

const components = [FaIcon, FaSprite, FaSprites]

export default {
  icons (list) {
    buildIconMap(list)

    library.add(...list)
  },

  install (Vue) {
    forEach(components, (component) => {
      Vue.component(component.name, component)
    })
  }
}

export { FaSprites }
