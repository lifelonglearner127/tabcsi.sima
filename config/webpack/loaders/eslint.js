const EslintFriendlyFormatter = require('eslint-friendly-formatter')
const path = require('path')

module.exports = {
  test: /\.(jsx?|vue)(\.erb)?$/i,
  loader: 'eslint-loader',
  enforce: 'pre',
  include: path.join(__dirname, '../../..', 'app/javascript'),
  options: {
    cache: true,
    emitError: true,
    emitWarning: true,
    failOnError: true,
    failOnWarning: true,
    formatter: EslintFriendlyFormatter
  }
}
