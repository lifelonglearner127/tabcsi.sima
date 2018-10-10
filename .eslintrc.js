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
    // disable native rules because of Babel plugin
    'new-cap': OFF,
    'no-unused-expressions': OFF,
    'object-curly-spacing': OFF,
    semi: OFF,
    'valid-typeof': OFF,

    'array-bracket-newline': ERROR,
    'array-bracket-spacing': ERROR,
    'array-callback-return': ERROR,
    'arrow-body-style': ERROR,
    'arrow-parens': ERROR,
    'babel/new-cap': standardConfig.rules['new-cap'],
    'babel/no-unused-expressions': standardConfig.rules['no-unused-expressions'],
    'babel/object-curly-spacing': standardConfig.rules['object-curly-spacing'],
    'babel/semi': standardConfig.rules.semi,
    'babel/valid-typeof': standardConfig.rules['valid-typeof'],
    'callback-return': ERROR,
    'computed-property-spacing': ERROR,
    'consistent-return': ERROR,
    'consistent-this': [ERROR, 'self'],
    'default-case': ERROR,
    'dot-notation': ERROR,
    'func-names': [ERROR, 'as-needed'],
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
    'newline-per-chained-call': ERROR,
    'no-await-in-loop': ERROR,
    'no-confusing-arrow': [ERROR, { allowParens: true }],
    'no-div-regex': ERROR,
    'no-duplicate-imports': [ERROR, { includeExports: true }],
    'no-else-return': ERROR,
    'no-empty-function': ERROR,
    'no-extra-label': ERROR,
    'no-implicit-coercion': ERROR,
    'no-implicit-globals': ERROR,
    'no-lonely-if': ERROR,
    'no-loop-func': ERROR,
    'no-magic-numbers': [ERROR, { ignore: [-1, 0, 1] }],
    'no-mixed-requires': [ERROR, { grouping: true }],
    'no-negated-condition': ERROR,
    'no-nested-ternary': ERROR,
    'no-process-exit': ERROR,
    'no-prototype-builtins': ERROR,
    'no-script-url': ERROR,
    'no-shadow': ERROR,
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
    radix: ERROR,
    'require-await': ERROR,
    'semi-style': [ERROR, 'first'],
    'sort-imports': [ERROR, { ignoreCase: true }],
    'sort-vars': [ERROR, { ignoreCase: true }],
    'switch-colon-spacing': ERROR,
    'vars-on-top': ERROR,
    'vue/component-name-in-template-casing': [ERROR, 'kebab-case'],
    'vue/jsx-uses-vars': OFF,
    'vue/multiline-html-element-content-newline': ERROR,
    'vue/no-spaces-around-equal-signs-in-attribute': ERROR,
    'vue/no-v-html': OFF,
    // Disabled until https://github.com/vuejs/eslint-plugin-vue/issues/595 is fixed.
    'vue/require-prop-type-constructor': OFF,
    'wrap-regex': ERROR,
    'you-dont-need-lodash-underscore/assign': OFF
  }
}
