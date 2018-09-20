import { getCaretPosition, getOperation, getSelection, setCaretPosition } from './dom'
import _format from './format'
import _parse from './parse'
import edit from './edit'

const formatInputText = (input, parse, format, operation, _onChange) => {
  // Parse input textual value. Get value and caret position.
  let { value, caret } = _parse(input.value, getCaretPosition(input), parse)

  // If a user performed an operation (e.g., "backspace" or "delete"), then apply that operation and get new value and
  // caret position.
  if (operation) {
    const operationApplied = edit(value, caret, operation)

    value = operationApplied.value
    caret = operationApplied.caret
  }

  // Format the value and reposition the caret accordingly.
  const formatted = _format(value, caret, format)
  const text = formatted.text

  caret = formatted.caret

  // Set input textual value manually to prevent accidental resetting of the caret position.
  input.value = text

  // Position the caret properly.
  setCaretPosition(input, caret)

  // input textual value may have changed, so the parsed value may have changed too. The value didn't necessarily
  // change, but it might have.
  _onChange(value)
}

const eraseSelection = (input, selection) => {
  let text

  text = input.value
  text = text.slice(0, selection.start) + text.slice(selection.end)

  input.value = text

  setCaretPosition(input, selection.start)
}

export const onChange = (input, parse, format, _onChange) => {
  formatInputText(input, parse, format, null, _onChange)
}

export const onCut = (input, parse, format, _onChange) => {
  // The actual cut hasn't happened just yet, hence the timeout.
  setTimeout(() => formatInputText(input, parse, format, null, _onChange), 0)
}

/// Intercepts "delete" and "backspace" keys. Pressing "delete" or "backspace" at any caret position should always
/// result in erasing a character.
export const onKeyDown = (e, input, parse, format, _onChange) => {
  const operation = getOperation(e)
  const selection = getSelection(input)

  switch (operation) {
    case 'Backspace':
    case 'Delete':
      // Intercept this operation and perform it manually.
      e.preventDefault()

      // If selection is made, then just erase the selected text, and don't apply any more operations to it.
      if (selection) {
        eraseSelection(input, selection)

        formatInputText(input, parse, format, null, _onChange)

        return
      }

      // Else, perform the (character erasing) operation manually.
      formatInputText(input, parse, format, operation, _onChange)

      break

    // no default
  }
}

export const onPaste = (input, parse, format, _onChange) => {
  const selection = getSelection(input)

  // If selection is made, then just erase the selected text prior to pasting.
  if (selection) {
    eraseSelection(input, selection)
  }

  formatInputText(input, parse, format, null, _onChange)
}
