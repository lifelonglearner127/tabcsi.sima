const standardConfig = require('eslint-config-standard/eslintrc.json')

const OFF = 'off'
const WARN = 'warn'
const ERROR = 'error'

module.exports = {
  extends: [
    'eslint:recommended',
    'plugin:flowtype/recommended',
    'plugin:lodash/recommended',
    'plugin:you-dont-need-lodash-underscore/compatible-warn',
    'plugin:vue/recommended',
    'standard'
  ],
  plugins: ['babel'],
  env: { commonjs: true },
  rules: {
    'array-bracket-newline': ERROR,
    'array-bracket-spacing': ERROR,
    'array-callback-return': ERROR,
    'arrow-body-style': ERROR,
    'arrow-parens': ERROR,
    'babel/new-cap': standardConfig.rules['new-cap'],
    'babel/no-invalid-this': ERROR,
    'babel/no-unused-expressions': standardConfig.rules['no-unused-expressions'],
    'babel/object-curly-spacing': [ERROR, 'always'],
    'babel/quotes': standardConfig.rules.quotes,
    'babel/semi': standardConfig.rules.semi,
    'callback-return': ERROR,
    'computed-property-spacing': ERROR,
    'consistent-return': ERROR,
    'consistent-this': [ERROR, 'self', 'that'],
    'default-case': ERROR,
    'dot-notation': ERROR,
    'for-direction': ERROR,
    'func-names': [ERROR, 'as-needed'],
    'getter-return': ERROR,
    'global-require': ERROR,
    'guard-for-in': ERROR,
    'init-declarations': [ERROR, 'never'],
    'jsx-quotes': ERROR,
    'linebreak-style': ERROR,
    'lines-between-class-members': ERROR,
    'lodash/prefer-lodash-method': [
      ERROR,
      {
        ignoreMethods: ['isArray', 'replace', 'toLower', 'toUpper', 'trim']
      }
    ],
    'max-len': [ERROR, {
      code: 120,
      ignoreTrailingComments: true,
      ignoreUrls: true
    }],
    'max-statements-per-line': ERROR,
    'new-cap': OFF, // disabled because of babel plugin
    'newline-per-chained-call': ERROR,
    'no-alert': ERROR,
    'no-await-in-loop': ERROR,
    'no-catch-shadow': ERROR,
    'no-confusing-arrow': [ERROR, { allowParens: true }],
    'no-console': WARN,
    'no-div-regex': ERROR,
    'no-duplicate-imports': [ERROR, { includeExports: true }],
    'no-else-return': ERROR,
    'no-empty-function': ERROR,
    'no-extra-label': ERROR,
    'no-implicit-coercion': ERROR,
    'no-implicit-globals': ERROR,
    'no-invalid-this': OFF, // disabled because of babel plugin
    'no-lonely-if': ERROR,
    'no-loop-func': ERROR,
    'no-magic-numbers': [ERROR, { ignore: [-1, 0, 1] }],
    'no-mixed-requires': [ERROR, { grouping: true }],
    'no-negated-condition': ERROR,
    'no-nested-ternary': ERROR,
    'no-param-reassign': ERROR,
    'no-process-exit': ERROR,
    'no-prototype-builtins': ERROR,
    'no-script-url': ERROR,
    'no-shadow': ERROR,
    'no-unused-expressions': OFF, // disabled because of babel plugin
    'no-useless-concat': ERROR,
    'no-var': ERROR,
    'no-warning-comments': [WARN, { terms: ['fixme', 'hack', 'todo', 'xxx'] }],
    'object-curly-newline': [ERROR, {
      ObjectExpression: {
        minProperties: 2,
        multiline: true
      },
      ObjectPattern: { multiline: true }
    }],
    'object-curly-spacing': OFF, // disabled because of babel plugin
    'object-shorthand': ERROR,
    'operator-assignment': ERROR,
    'padding-line-between-statements': [
      ERROR,
      {
        blankLine: 'always',
        prev: ['const', 'let', 'var'],
        next: '*'
      },
      {
        blankLine: 'any',
        prev: ['const', 'let', 'var'],
        next: ['const', 'let', 'var']
      },
      {
        blankLine: 'always',
        prev: '*',
        next: 'return'
      }
    ],
    'prefer-arrow-callback': ERROR,
    'prefer-const': ERROR,
    'prefer-numeric-literals': ERROR,
    'prefer-rest-params': ERROR,
    'prefer-spread': ERROR,
    'prefer-template': ERROR,
    'quote-props': [ERROR, 'as-needed'],
    'quotes': OFF, // disabled because of babel plugin
    radix: ERROR,
    'require-await': ERROR,
    semi: OFF, // disabled because of babel plugin
    'semi-style': [ERROR, 'first'],
    'sort-imports': [ERROR, { ignoreCase: true }],
    'sort-vars': [ERROR, { ignoreCase: true }],
    'switch-colon-spacing': ERROR,
    'vars-on-top': ERROR,
    'vue/no-v-html': OFF,
    // Disabled until https://github.com/vuejs/eslint-plugin-vue/issues/595 is fixed.
    'vue/require-prop-type-constructor': OFF,
    'wrap-regex': ERROR,
    'you-dont-need-lodash-underscore/assign': OFF
  }
}
