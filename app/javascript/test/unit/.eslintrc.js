const OFF = 'off'
// const WARN = 'warn'
const ERROR = 'error'

module.exports = {
  plugins: ['jasmine'],
  env: { jasmine: true },
  rules: {
    'func-names': OFF,
    'jasmine/expect-matcher': ERROR,
    'jasmine/expect-single-argument': ERROR,
    'jasmine/missing-expect': ERROR,
    'jasmine/named-spy': ERROR,
    'jasmine/new-line-before-expect': ERROR,
    'jasmine/new-line-between-declarations': ERROR,
    'jasmine/no-assign-spyon': ERROR,
    'jasmine/no-describe-variables': ERROR,
    'jasmine/no-disabled-tests': ERROR,
    'jasmine/no-expect-in-setup-teardown': ERROR,
    'jasmine/no-focused-tests': ERROR,
    'jasmine/no-global-setup': ERROR,
    'jasmine/no-spec-dupes': [ERROR, 'branch'],
    'jasmine/no-suite-callback-args': ERROR,
    'jasmine/no-suite-dupes': [ERROR, 'branch'],
    'jasmine/no-unsafe-spy': ERROR,
    'jasmine/prefer-jasmine-matcher': ERROR,
    'jasmine/prefer-toHaveBeenCalledWith': OFF,
    'no-console': OFF,
    'prefer-arrow-callback': OFF
  }
}
