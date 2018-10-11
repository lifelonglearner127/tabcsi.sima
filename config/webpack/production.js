process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const env = require('./environment')

if (process.env.APP_DEBUG === 'true') {
  env.config.set('devtool', 'source-map')
}

module.exports = env.toWebpackConfig()
