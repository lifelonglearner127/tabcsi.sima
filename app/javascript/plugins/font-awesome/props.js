import { genEnumValidator } from '~/lib/utils'

const ROTATION_90 = 90
const ROTATION_180 = 180
const ROTATION_270 = 270
const ROTATION_VALUES = [ROTATION_90, ROTATION_180, ROTATION_270]

export const iconSizeProp = {
  type: String,
  default: null,
  validator: genEnumValidator(['lg', 'xs', 'sm', '1x', '2x', '3x', '4x', '5x', '6x', '7x', '8x', '9x', '10x'])
}

export default {
  border: {
    type: Boolean,
    default: false
  },
  fixedWidth: {
    type: Boolean,
    default: false
  },
  flip: {
    type: String,
    default: null,
    validator: genEnumValidator(['horizontal', 'vertical', 'both'])
  },
  listItem: {
    type: Boolean,
    default: false
  },
  mask: {
    type: [Object, Array, String],
    default: null
  },
  noWrapper: {
    type: Boolean,
    default: false
  },
  pull: {
    type: String,
    default: null,
    validator: genEnumValidator(['right', 'left'])
  },
  pulse: {
    type: Boolean,
    default: false
  },
  rotation: {
    type: Number,
    default: null,
    validator: genEnumValidator(ROTATION_VALUES)
  },
  size: iconSizeProp,
  spin: {
    type: Boolean,
    default: false
  },
  transform: {
    type: [String, Object],
    default: null
  }
}
