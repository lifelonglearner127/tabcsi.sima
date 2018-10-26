import XRegExp from 'xregexp'

const TITLEIZE_REG_EXP = XRegExp('(\\s)?(\\S)(\\S*)', 'g')

export const titleizeValue = (rawValue, _event) => rawValue.replace(
  TITLEIZE_REG_EXP,
  (_, space = '', firstLetter, restOfWord = '') => `${space}${firstLetter.toLocaleUpperCase()}${restOfWord}`
)
