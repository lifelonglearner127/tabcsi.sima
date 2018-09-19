export const VARIANT_DANGER = 'danger'
export const VARIANT_INFO = 'info'
export const VARIANT_NORMAL = 'normal'
export const VARIANT_PRIMARY = 'primary'
export const VARIANT_SECONDARY = 'secondary'
export const VARIANT_SUCCESS = 'success'
export const VARIANT_WARNING = 'warning'

export const TYPE_ERROR = 'error'
export const TYPE_INFO = VARIANT_INFO
export const TYPE_SUCCESS = VARIANT_SUCCESS
export const TYPE_WARNING = VARIANT_WARNING

export const TYPES = [TYPE_ERROR, TYPE_INFO, TYPE_SUCCESS, TYPE_WARNING]

export const TYPE_VARIANT_MAP = {
  [TYPE_ERROR]: VARIANT_DANGER,
  [TYPE_INFO]: VARIANT_INFO,
  [TYPE_SUCCESS]: VARIANT_SUCCESS,
  [TYPE_WARNING]: VARIANT_WARNING
}

export const ICON_MAP = {
  [VARIANT_DANGER]: 'fas-fa-times-circle',
  [VARIANT_INFO]: 'fas-fa-info-circle',
  [VARIANT_SUCCESS]: 'fas-fa-check-circle',
  [VARIANT_WARNING]: 'fas-fa-exclamation-circle'
}
