const dotenv = require('dotenv')
const forEach = require('lodash/forEach')
const { resolve } = require('path')
const { VueLoaderPlugin } = require('vue-loader')

// Load `.env` before loading Webpacker config to allow it to use any set environment variables.
dotenv.config()

// Load Webpacker config explicitly to allow config modifications before Webpacker environments are built.
const config = require('./config')
const { environment: env } = require('@rails/webpacker')
const vue = require('./loaders/vue')

env.loaders.prepend('vue', vue) // The vue-loader rule needs to come before babel, css, and sass rules.
env.plugins.append('VueLoader', new VueLoaderPlugin())

const LOADER_OFFSET = config.extractCss ? 1 : 0
const STYLE_LOADER_BASE_INDEX = 0
const SASS_LOADER_BASE_INDEX = 3
const SASS_PRECISION = 12

const css = env.loaders.get('css')
const moduleCss = env.loaders.get('moduleCss')
const moduleSass = env.loaders.get('moduleSass')
const sass = env.loaders.get('sass')
const styleLoaderIndex = STYLE_LOADER_BASE_INDEX + LOADER_OFFSET
const sassLoaderIndex = SASS_LOADER_BASE_INDEX + LOADER_OFFSET

// Clean up RegExps.
env.loaders.get('babel').test = /\.(?:jsx?)?(?:\.erb)?$/
css.test = moduleCss.test = /\.css$/i
moduleSass.test = sass.test = /\.s[ac]ss$/i
env.loaders.get('file').test = /\.(?:jpe?g|png|gif|tiff?|ico|svg|eot|[ot]tf|woff2?)$/i

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
forEach([css, moduleCss, moduleSass, sass], (loader) => {
  loader.use[styleLoaderIndex] = {
    loader: 'vue-style-loader',
    options: {
      hmr: config.isHmr,
      sourceMap: true
    }
  }
})

moduleSass.use[sassLoaderIndex].options.precision = sass.use[sassLoaderIndex].options.precision = SASS_PRECISION

const rootResolve = (path) => resolve(config.source_path, path)

env.config.set('resolve.alias', {
  '@': rootResolve('.'),
  '@@': rootResolve('../..'),
  '~': rootResolve('.'),
  '~~': rootResolve('../..'),
  vue$: 'vue/dist/vue.esm.js'
})

module.exports = env
