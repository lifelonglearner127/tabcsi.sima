process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const env = require('./environment')

env.config.set('devtool', 'source-map')

module.exports = env.toWebpackConfig()
