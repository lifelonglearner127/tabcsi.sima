process.env.NODE_ENV = process.env.NODE_ENV || 'test'

const env = require('./environment')

env.plugins.get('Manifest').opts.writeToFileEmit = process.env.NODE_ENV !== 'test'

env.loaders.append('istanbul-instrumenter', {
  test: /\.js$/,
  enforce: 'post',
  loader: 'istanbul-instrumenter-loader',
  query: { esModules: true },
  exclude: [/node_modules/, /\.test\.js$/]
})

const webpackConfig = env.toWebpackConfig()

delete webpackConfig.entry

module.exports = webpackConfig
