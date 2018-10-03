/*
 * Reload `webpacker.yml` file to utilize `shared` config.
 */

let publicPath

// `config` will be set to the defaults, so no need to load defaults again.
const config = require('@rails/webpacker/package/config')
const defaultsDeep = require('lodash/defaultsDeep')
const find = require('lodash/find')
const forEach = require('lodash/forEach')
const includes = require('lodash/includes')
const isArray = require('lodash/isArray')
const merge = require('lodash/merge')
const { railsEnv } = require('@rails/webpacker/package/env')
const { readFileSync } = require('fs')
const replace = require('lodash/replace')
const { resolve } = require('path')
const { safeLoad } = require('js-yaml')

const configPath = resolve('config', 'webpacker.yml')
const loadedYaml = safeLoad(readFileSync(configPath), 'utf8')
const shared = loadedYaml.shared

delete loadedYaml.shared

if (shared) {
  forEach(loadedYaml, (values) => {
    defaultsDeep(values, shared)
  })
}

const app = loadedYaml[railsEnv]

if (isArray(app.extensions) && app.extensions.length) {
  delete config.extensions
}

merge(config, app)

config.outputPath = resolve('public', config.public_output_path)
publicPath = `/${config.public_output_path}/`

// Add prefix to publicPath.
if (process.env.RAILS_RELATIVE_URL_ROOT) {
  publicPath = `/${process.env.RAILS_RELATIVE_URL_ROOT}${publicPath}`
}

// Remove extra slashes.
config.publicPath = replace(publicPath, /(^\/|[^:]\/)\/+/g, '$1')

const devServer = config.dev_server

config.isProduction = process.env.NODE_ENV === 'production'
config.inDevServer = Boolean(find(process.argv, (v) => includes(v, 'webpack-dev-server')))
config.isHmr = config.inDevServer && (devServer && devServer.hmr)
config.extractCss = !config.isHmr || config.isProduction

module.exports = config
