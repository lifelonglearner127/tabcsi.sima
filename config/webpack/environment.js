const dotenv = require('dotenv')

// Load `.env` before loading Webpacker config to allow it to use any set environment variables.
dotenv.config()

const forEach = require('lodash/forEach')
const { resolve } = require('path')
const { VueLoaderPlugin } = require('vue-loader')

// Load Webpacker config explicitly to allow config modifications before Webpacker environments are built.
const config = require('./config')
const { environment: env } = require('@rails/webpacker')

if (!config.isProduction) {
  const eslint = require('./loaders/eslint') // eslint-disable-line global-require

  env.loaders.prepend('eslint', eslint)
}

const vue = require('./loaders/vue')

env.plugins.append('VueLoaderPlugin', new VueLoaderPlugin())
env.loaders.append('vue', vue)

const POSTCSS_LOADER_INDEX = 2
const SASS_LOADER_INDEX = 3
const SASS_PRECISION = 12

const cssLoaders = ['css', 'moduleCss', 'moduleSass', 'sass']

forEach(cssLoaders, (cssLoaderName) => {
  const loader = env.loaders.get(cssLoaderName)

  loader.use[POSTCSS_LOADER_INDEX].options.config = { path: resolve() }

  if (loader.use[SASS_LOADER_INDEX] != null) {
    loader.use[SASS_LOADER_INDEX].options.precision = SASS_PRECISION
  }
})

const rootResolve = (path) => resolve(config.source_path, path)

env.config.set('resolve.alias', {
  '@': rootResolve('.'),
  '@@': rootResolve('../..'),
  '~': rootResolve('.'),
  '~~': rootResolve('../..'),
  'bootstrap-vue$': 'bootstrap-vue/src/index.js',
  vue$: 'vue/dist/vue.esm.js'
})

module.exports = env
