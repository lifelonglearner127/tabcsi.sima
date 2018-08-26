import FontAwesomeContainer from './container'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import iconProps from './props'

export default {
  name: 'FaIcon',

  functional: true,

  props: {
    ...iconProps,
    icon: {
      type: [Object, Array, String],
      required: true
    },
    symbol: {
      type: [Boolean, String],
      default: false
    },
    use: {
      type: String,
      default: null
    }
  },

  render (h, { data, props }) {
    const noWrapper = props.noWrapper
    const size = props.size
    const use = props.use
    const iconOptions = {
      ...data,
      props
    }

    delete props.noWrapper
    delete props.use

    if (!noWrapper) {
      iconOptions.style = { verticalAlign: '0.125em' }
    }

    const icon = h(FontAwesomeIcon, iconOptions)

    if (!use && !props.symbol) {
      if (noWrapper) {
        return icon
      }

      return h(FontAwesomeContainer, { props: { size } }, [icon])
    }

    if (use) {
      const svgUse = h('use', { attrs: { 'xlink:href': `#${use}` } })

      icon.children = [svgUse]
    }

    return icon
  }
}
