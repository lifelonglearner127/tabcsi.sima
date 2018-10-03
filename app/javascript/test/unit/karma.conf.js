const webpackConfig = require('../../../../config/webpack/test')

module.exports = (config) => {
  config.set({
    browsers: ['PhantomJS'],

    coverageIstanbulReporter: {
      fixWebpackSourcePaths: true,
      reports: ['html', 'lcovonly', 'text-summary']
    },

    files: ['./tests/**/*.test.js'],
    frameworks: ['jasmine', 'phantomjs-shim'],
    // logLevel: config.LOG_DEBUG,
    preprocessors: { './tests/**/*.test.js': ['webpack', 'sourcemap'] },
    reporters: ['spec', 'coverage-istanbul'],
    singleRun: true,
    webpack: webpackConfig,
    webpackMiddleware: { noInfo: true }
  })
}
