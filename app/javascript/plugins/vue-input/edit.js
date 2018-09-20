export default (_value, _caret, operation) => {
  let caret, value

  caret = _caret
  value = _value

  switch (operation) {
    case 'Backspace':
      // If there's a previous character, then erase it and reposition the caret.
      if (caret > 0) {
        // remove the previous character
        value = value.slice(0, caret - 1) + value.slice(caret)

        // position the caret where the previous (erased) character was
        --caret
      }

      break

    case 'Delete':
      // remove current character (if any)
      value = value.slice(0, caret) + value.slice(caret + 1)
      break

    // no default
  }

  return {
    value, caret
  }
}
