import FontAwesomeContainer from './container'
import FontAwesomeIcon from './icon'
import { iconMap } from './icons'
import iconProps from './props'

export default {
  name: 'FaSprite',

  functional: true,

  props: {
    ...iconProps,
    use: {
      type: String,
      required: true
    }
  },

  render (h, { data, props }) {
    const size = props.size
    const icon = h(FontAwesomeIcon, {
      ...data,
      props: {
        ...props,
        icon: iconMap[props.use]
      }
    })

    if (props.noWrapper) {
      return icon
    }

    return h(FontAwesomeContainer, { props: { size } }, [icon])
  }
}
