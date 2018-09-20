const keys = {
  8: 'Backspace',
  46: 'Delete'
}

export const getOperation = (e) => keys[e.keyCode]

export const getCaretPosition = (el) => el.selectionStart

export const getSelection = (el) => {
  // If no selection, return nothing.
  if (el.selectionStart === el.selectionEnd) {
    return null
  }

  return {
    start: el.selectionStart,
    end: el.selectionEnd
  }
}

export const setCaretPosition = (el, position) => {
  // sanity check
  if (position == null) {
    return
  }

  el.setSelectionRange(position, position)
}
