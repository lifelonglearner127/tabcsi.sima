const dotenv = require('dotenv')

// Load `.env` before loading Webpacker config to allow it to use any set environment variables.
dotenv.config()

// const forEach = require('lodash/forEach')
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

// const STYLE_LOADER_INDEX = 0
const SASS_LOADER_INDEX = 3
const SASS_PRECISION = 12

// const css = env.loaders.get('css')
// const moduleCss = env.loaders.get('moduleCss')
const moduleSass = env.loaders.get('moduleSass')
const sass = env.loaders.get('sass')

// For debugging.
// forEach(
//   {
//     css, moduleCss, moduleSass, sass
//   },
//   (loader, loaderName) => {
//     console.log(loaderName, loader)
//
//     forEach(loader.use, (use, index) => {
//       console.log(index, use.options)
//     })
//
//     console.log('')
//   }
// )

// Switch to the vue-style-loader.
// forEach([css, moduleCss, moduleSass, sass], (loader) => {
//   loader.use[STYLE_LOADER_INDEX] = {
//     loader: 'vue-style-loader',
//     options: {
//       hmr: config.isHmr,
//       sourceMap: true
//     }
//   }
// })

moduleSass.use[SASS_LOADER_INDEX].options.precision =
  sass.use[SASS_LOADER_INDEX].options.precision = SASS_PRECISION

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
