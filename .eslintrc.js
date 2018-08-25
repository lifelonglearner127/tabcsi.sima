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
  parserOptions: { parser: 'babel-eslint' },
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
        ignoreMethods: ['isArray', 'replace', 'toLower', 'toUpper']
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
    'vue/attribute-hyphenation': ERROR,
    'vue/html-end-tags': ERROR,
    'vue/html-quotes': ERROR,
    'vue/html-self-closing': [ERROR, {
      html: { component: 'never' }
    }],
    'vue/max-attributes-per-line': [ERROR, { singleline: 1 }],
    'vue/mustache-interpolation-spacing': ERROR,
    'vue/name-property-casing': ERROR,
    'vue/no-async-in-computed-properties': ERROR,
    'vue/no-dupe-keys': ERROR,
    'vue/no-duplicate-attributes': ERROR,
    'vue/no-multi-spaces': ERROR,
    'vue/no-parsing-error': [ERROR, {
      'abrupt-closing-of-empty-comment': true,
      'absence-of-digits-in-numeric-character-reference': true,
      'cdata-in-html-content': true,
      'character-reference-outside-unicode-range': true,
      'control-character-in-input-stream': true,
      'control-character-reference': true,
      'duplicate-attribute': true,
      'end-tag-with-attributes': true,
      'end-tag-with-trailing-solidus': true,
      'eof-before-tag-name': true,
      'eof-in-cdata': true,
      'eof-in-comment': true,
      'eof-in-tag': true,
      'incorrectly-closed-comment': true,
      'incorrectly-opened-comment': true,
      'invalid-first-character-of-tag-name': true,
      'missing-attribute-value': true,
      'missing-end-tag-name': true,
      'missing-semicolon-after-character-reference': true,
      'missing-whitespace-between-attributes': true,
      'nested-comment': true,
      'non-void-html-element-start-tag-with-trailing-solidus': false,
      'noncharacter-character-reference': true,
      'noncharacter-in-input-stream': true,
      'null-character-reference': true,
      'surrogate-character-reference': true,
      'surrogate-in-input-stream': true,
      'unexpected-character-in-attribute-name': true,
      'unexpected-character-in-unquoted-attribute-value': true,
      'unexpected-equals-sign-before-attribute-name': true,
      'unexpected-null-character': true,
      'unexpected-question-mark-instead-of-tag-name': true,
      'unexpected-solidus-in-tag': true,
      'unknown-named-character-reference': true,
      'x-invalid-end-tag': true,
      'x-invalid-namespace': true
    }],
    'vue/no-reserved-keys': ERROR,
    'vue/no-shared-component-data': ERROR,
    'vue/no-side-effects-in-computed-properties': ERROR,
    'vue/no-template-key': ERROR,
    'vue/order-in-components': [ERROR, {
      order: [
        'el',
        'name',
        'parent',
        'functional',
        'delimiters',
        'comments',
        'components',
        'directives',
        'filters',
        'extends',
        'mixins',
        ['provide', 'inject'],
        'inheritAttrs',
        'model',
        ['props', 'propsData'],
        'data',
        'computed',
        'watch',
        'LIFECYCLE_HOOKS',
        'methods',
        ['template', 'render'],
        'renderError'
      ]
    }],
    'vue/require-default-prop': ERROR,
    'vue/require-prop-types': ERROR,
    'vue/require-render-return': ERROR,
    'vue/require-valid-default-prop': ERROR,
    'vue/return-in-computed-property': ERROR,
    'vue/this-in-template': ERROR,
    'vue/v-bind-style': ERROR,
    'vue/v-on-style': ERROR,
    'wrap-regex': ERROR
  }
}
