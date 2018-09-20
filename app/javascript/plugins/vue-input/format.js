export default (value, _caret, formatter) => {
  let caret, text

  caret = _caret

  const formatted = formatter(value) || {}
  const template = formatted.template

  text = formatted.text
  if (text == null) {
    text = value
  }

  if (template) {
    if (caret == null) {
      caret = text.length
    } else {
      let found, index, possiblyLastInputCharacterIndex

      found = false
      index = 0
      possiblyLastInputCharacterIndex = -1

      while (index < text.length && index < template.length) {
        // character placeholder found
        if (text[index] !== template[index]) {
          if (caret === 0) {
            found = true
            caret = index

            break
          }

          possiblyLastInputCharacterIndex = index
          --caret
        }

        ++index
      }

      // If the caret was positioned after last input character, then the text caret index is just after the last input
      // character.
      if (!found) {
        caret = possiblyLastInputCharacterIndex + 1
      }
    }
  }

  return {
    text, caret
  }
}
