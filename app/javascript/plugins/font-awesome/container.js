import { iconSizeProp } from './props'

const iconSize = (size) => {
  let height

  switch (size) {
    case 'xs':
      height = '0.75em'
      break

    case 'sm':
      height = '0.875em'
      break

    case 'lg':
      height = '1.33333em'
      break

    case '2x':
    case '3x':
    case '4x':
    case '5x':
    case '6x':
    case '7x':
    case '8x':
    case '9x':
    case '10x':
      height = `${parseInt(size, 10)}em`
      break

    default:
      height = '1em'
  }

  return height
}

export default {
  name: 'FaContainer',

  functional: true,

  props: { size: iconSizeProp },

  render (h, { children, props }) {
    return h(
      'div',
      {
        class: 'fa-container',
        style: {
          display: 'inline-block',
          height: iconSize(props.size),
          verticalAlign: '-0.25em'
        }
      },
      children
    )
  }
}
