import { VARIANT_DANGER, VARIANT_PRIMARY, VARIANT_SECONDARY } from '../variants'

export const ABORT = 'abort'
export const ABORT_TEXT = 'Abort'
export const ABORT_RETRY_IGNORE = 'abort-retry-ignore'
export const CANCEL = 'cancel'
export const CANCEL_TEXT = 'Cancel'
export const CLOSE = 'close'
export const IGNORE = 'ignore'
export const IGNORE_TEXT = 'Ignore'
export const NO = 'no'
export const NO_TEXT = 'No'
export const OK = 'ok'
export const OK_TEXT = 'OK'
export const OK_CANCEL = 'ok-cancel'
export const RETRY = 'retry'
export const RETRY_TEXT = 'Retry'
export const RETRY_CANCEL = 'retry-cancel'
export const YES = 'yes'
export const YES_TEXT = 'Yes'
export const YES_NO = 'yes-no'
export const YES_NO_CANCEL = 'yes-no-cancel'

export const BUTTON_VALUES = [ABORT_RETRY_IGNORE, OK, OK_CANCEL, RETRY_CANCEL, YES_NO, YES_NO_CANCEL]
export const BUTTON_NAMES = [ABORT, CANCEL, IGNORE, NO, OK, RETRY, YES]
export const BUTTON_HANDLER_NAMES = [...BUTTON_NAMES, CLOSE, 'error']

const BUTTONS = {
  [ABORT]: {
    variant: VARIANT_DANGER,
    text: ABORT_TEXT
  },
  [CANCEL]: {
    variant: VARIANT_SECONDARY,
    text: CANCEL_TEXT
  },
  [IGNORE]: {
    variant: VARIANT_SECONDARY,
    text: IGNORE_TEXT
  },
  [NO]: {
    variant: VARIANT_DANGER,
    text: NO_TEXT
  },
  [OK]: {
    variant: VARIANT_PRIMARY,
    text: OK_TEXT
  },
  [RETRY]: {
    variant: VARIANT_PRIMARY,
    text: RETRY_TEXT
  },
  [YES]: {
    variant: VARIANT_PRIMARY,
    text: YES_TEXT
  }
}

export const BUTTON_MAP = {
  [ABORT_RETRY_IGNORE]: {
    [ABORT]: BUTTONS[ABORT],
    [RETRY]: BUTTONS[RETRY],
    [IGNORE]: BUTTONS[IGNORE]
  },
  [OK]: { [OK]: BUTTONS[OK] },
  [OK_CANCEL]: {
    [OK]: BUTTONS[OK],
    [CANCEL]: BUTTONS[CANCEL]
  },
  [RETRY_CANCEL]: {
    [RETRY]: BUTTONS[RETRY],
    [CANCEL]: BUTTONS[CANCEL]
  },
  [YES_NO]: {
    [YES]: BUTTONS[YES],
    [NO]: BUTTONS[NO]
  },
  [YES_NO_CANCEL]: {
    [YES]: BUTTONS[YES],
    [NO]: BUTTONS[NO],
    [CANCEL]: BUTTONS[CANCEL]
  }
}
