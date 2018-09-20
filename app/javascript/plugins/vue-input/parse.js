export default (text, caretPosition, parseCharacter) => {
  let caret, index, value

  value = ''
  caret = 0
  index = 0

  while (index < text.length) {
    const ch = parseCharacter(text[index], value)

    if (ch != null) {
      value += ch

      if (caretPosition != null && caretPosition >= index) {
        caret = value.length

        if (caretPosition === index) {
          --caret
        }
      }
    }

    ++index
  }

  // If caret position wasn't specified, then set caret position to "after the last input character."
  if (caretPosition == null) {
    caret = value.length
  }

  return {
    value, caret
  }
}
