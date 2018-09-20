import { AsYouTypeCustom, isValidNumberCustom } from 'libphonenumber-js'
import metadata from '~/assets/files/metadata.json'

const US_CODE = 'US'

// export const format = (input) => formatCustom(input, US_CODE, 'National', metadata)
// export const getNumberType = (input) => getNumberTypeCustom(input, US_CODE, metadata)
export const isValidNumber = (input) => isValidNumberCustom(input, US_CODE, metadata)
// export const parse = (text) => parseCustom(text, US_CODE, metadata)

export class AsYouType extends AsYouTypeCustom {
  constructor () {
    super(US_CODE, metadata)
  }
}
