module.exports = {
  extends: ['stylelint-config-standard'],
  processors: ['@mapbox/stylelint-processor-arbitrary-tags'],
  plugins: ['stylelint-scss'],
  rules: {
    'at-rule-blacklist': [],
    'at-rule-empty-line-before': [
      'always',
      {
        except: [
          'blockless-after-same-name-blockless',
          'first-nested'
        ],
        ignore: ['after-comment'],
        ignoreAtRules: ['else']
      }
    ],
    // 'at-rule-name-case': 'lower', // stylelint-config-standard
    // 'at-rule-name-space-after': 'always-single-line', // stylelint-config-standard
    'at-rule-no-unknown': null,
    // 'at-rule-no-vendor-prefix': true, // stylelint-config-standard
    // 'at-rule-semicolon-newline-after': 'always', // stylelint-config-standard
    'at-rule-semicolon-space-before': 'never',
    // 'at-rule-whitelist': [],
    // 'block-closing-brace-empty-line-before': 'never', // stylelint-config-standard
    // 'block-closing-brace-newline-after': 'always', // stylelint-config-standard
    'block-closing-brace-newline-before': 'always',
    'block-closing-brace-space-after': 'always-single-line',
    // 'block-closing-brace-space-before': 'always-single-line', // stylelint-config-standard
    // 'block-no-empty': true, // stylelint-config-recommended
    'block-opening-brace-newline-after': 'always',
    'block-opening-brace-newline-before': null,
    // 'block-opening-brace-space-after': 'always-single-line', // stylelint-config-standard
    // 'block-opening-brace-space-before': 'always', // stylelint-config-standard
    // 'color-hex-case': 'lower', // stylelint-config-standard
    'color-hex-length': 'long',
    'color-named': 'never',
    'color-no-hex': null,
    // 'color-no-invalid-hex': true, // stylelint-config-recommended
    // 'comment-empty-line-before': [ // stylelint-config-standard
    //   'always',
    //   {
    //     except: ['first-nested'],
    //     ignore: ['stylelint-commands']
    //   }
    // ],
    // 'comment-no-empty': true, // stylelint-config-recommended
    // 'comment-whitespace-inside': 'always', // stylelint-config-standard
    // 'comment-word-blacklist': [],
    'custom-media-pattern': null,
    // 'custom-property-empty-line-before': [ // stylelint-config-standard
    //   'always',
    //   {
    //     except: [
    //       'after-custom-property',
    //       'first-nested'
    //     ],
    //     ignore: [
    //       'after-comment',
    //       'inside-single-line-block'
    //     ]
    //   }
    // ],
    'custom-property-pattern': null,
    // 'declaration-bang-space-after': 'never', // stylelint-config-standard
    // 'declaration-bang-space-before': 'always', // stylelint-config-standard
    // 'declaration-block-no-duplicate-properties': [ // stylelint-config-recommended
    //   true,
    //   { ignore: ['consecutive-duplicates-with-different-values'] }
    // ],
    'declaration-block-no-redundant-longhand-properties': true,
    // 'declaration-block-no-shorthand-property-overrides': true, // stylelint-config-recommended
    'declaration-block-semicolon-newline-after': 'always',
    'declaration-block-semicolon-newline-before': 'never-multi-line',
    // 'declaration-block-semicolon-space-after': 'always-single-line', // stylelint-config-standard
    // 'declaration-block-semicolon-space-before': 'never', // stylelint-config-standard
    // 'declaration-block-single-line-max-declarations': 1, // stylelint-config-standard
    // 'declaration-block-trailing-semicolon': 'always', // stylelint-config-standard
    // 'declaration-colon-newline-after': 'always-multi-line', // stylelint-config-standard
    // 'declaration-colon-space-after': 'always-single-line', // stylelint-config-standard
    // 'declaration-colon-space-before': 'never', // stylelint-config-standard
    // 'declaration-empty-line-before': [ // stylelint-config-standard
    //   'always',
    //   {
    //     except: [
    //       'after-declaration',
    //       'first-nested'
    //     ],
    //     ignore: [
    //       'after-comment',
    //       'inside-single-line-block'
    //     ]
    //   }
    // ],
    'declaration-no-important': null,
    // 'declaration-property-unit-blacklist': [],
    // 'declaration-property-unit-whitelist': [],
    // 'declaration-property-value-blacklist': [],
    // 'declaration-property-value-whitelist': [],
    'font-family-name-quotes': 'always-where-recommended',
    // 'font-family-no-duplicate-names': true, // stylelint-config-recommended
    // 'font-family-no-missing-generic-family-keyword': true, // stylelint-config-recommended
    'font-weight-notation': null,
    // 'function-blacklist': [],
    // 'function-calc-no-unspaced-operator': true, // stylelint-config-recommended
    // 'function-comma-newline-after': 'always-multi-line', // stylelint-config-standard
    'function-comma-newline-before': 'never-multi-line',
    // 'function-comma-space-after': 'always-single-line', // stylelint-config-standard
    // 'function-comma-space-before': 'never', // stylelint-config-standard
    // 'function-linear-gradient-no-nonstandard-direction': true, // stylelint-config-recommended
    // 'function-max-empty-lines': 0, // stylelint-config-standard
    // 'function-name-case': 'lower', // stylelint-config-standard
    // 'function-parentheses-newline-inside': 'always-multi-line', // stylelint-config-standard
    // 'function-parentheses-space-inside': 'never-single-line', // stylelint-config-standard
    'function-url-no-scheme-relative': true,
    'function-url-quotes': 'always',
    // 'function-url-scheme-blacklist': [],
    // 'function-url-scheme-whitelist': [],
    // 'function-whitelist': [],
    // 'function-whitespace-after': 'always', // stylelint-config-standard
    // 'indentation': 2, // stylelint-config-standard
    // 'keyframe-declaration-no-important': true, // stylelint-config-recommended
    // 'length-zero-no-unit': true, // stylelint-config-standard
    // 'max-empty-lines': 1, // stylelint-config-standard
    'max-line-length': 80,
    // 'max-nesting-depth': 2,
    // 'media-feature-colon-space-after': 'always', // stylelint-config-standard
    // 'media-feature-colon-space-before': 'never', // stylelint-config-standard
    // 'media-feature-name-blacklist': [],
    // 'media-feature-name-case': 'lower', // stylelint-config-standard
    // 'media-feature-name-no-unknown': true, // stylelint-config-recommended
    'media-feature-name-no-vendor-prefix': null,
    // 'media-feature-name-whitelist': [],
    // 'media-feature-parentheses-space-inside': 'never', // stylelint-config-standard
    // 'media-feature-range-operator-space-after': 'always', // stylelint-config-standard
    // 'media-feature-range-operator-space-before': 'always', // stylelint-config-standard
    // 'media-query-list-comma-newline-after': 'always-multi-line', // stylelint-config-standard
    'media-query-list-comma-newline-before': null,
    // 'media-query-list-comma-space-after': 'always-single-line', // stylelint-config-standard
    // 'media-query-list-comma-space-before': 'never', // stylelint-config-standard
    // 'no-descending-specificity': true, // stylelint-config-recommended
    // 'no-duplicate-at-import-rules': true, // stylelint-config-recommended
    // 'no-duplicate-selectors': true, // stylelint-config-recommended
    'no-empty-source': null,
    // 'no-eol-whitespace': true, // stylelint-config-standard
    // 'no-extra-semicolons': true, // stylelint-config-recommended
    // 'no-invalid-double-slash-comments': true, // stylelint-config-recommended
    // 'no-missing-end-of-source-newline': true, // stylelint-config-standard
    // 'number-leading-zero': 'always', // stylelint-config-standard
    'number-max-precision': null,
    // 'number-no-trailing-zeros': true, // stylelint-config-standard
    // 'property-blacklist': [],
    // 'property-case': 'lower', // stylelint-config-standard
    // 'property-no-unknown': true, // stylelint-config-recommended
    'property-no-vendor-prefix': null,
    // 'property-whitelist': [],
    // 'rule-empty-line-before': [ // stylelint-config-standard
    //   'always-multi-line',
    //   {
    //     except: ['first-nested'],
    //     ignore: ['after-comment']
    //   }
    // ],
    // 'scss/at-else-closing-brace-newline-after': 'always-last-in-chain',
    // 'scss/at-else-closing-brace-space-after': 'always-intermediate',
    'scss/at-else-empty-line-before': 'never',
    'scss/at-else-if-parentheses-space-before': 'always',
    // 'scss/at-extend-no-missing-placeholder': true,
    // 'scss/at-function-named-arguments': 'always',
    'scss/at-function-parentheses-space-before': 'always',
    'scss/at-function-pattern': null,
    // 'scss/at-if-closing-brace-newline-after': 'always-last-in-chain',
    // 'scss/at-if-closing-brace-space-after': 'always-intermediate',
    'scss/at-import-no-partial-leading-underscore': true,
    // 'scss/at-import-partial-extension-blacklist': [],
    // 'scss/at-import-partial-extension-whitelist': [],
    'scss/at-mixin-argumentless-call-parentheses': 'never',
    // 'scss/at-mixin-named-arguments': 'always',
    'scss/at-mixin-parentheses-space-before': 'always',
    'scss/at-mixin-pattern': null,
    'scss/at-rule-no-unknown': true,
    // 'scss/declaration-nested-properties': 'always',
    'scss/declaration-nested-properties-no-divided-groups': true,
    // 'scss/dollar-variable-colon-newline-after': 'always-multi-line',
    // 'scss/dollar-variable-colon-space-after': 'always-single-line',
    'scss/dollar-variable-colon-space-before': 'never',
    // 'scss/dollar-variable-empty-line-before': [
    //   'always',
    //   { except: ['after-comment', 'after-dollar-variable', 'first-nested'] }
    // ],
    // 'scss/dollar-variable-no-missing-interpolation': true,
    'scss/dollar-variable-pattern': null,
    // 'scss/double-slash-comment-empty-line-before': [
    //   'always',
    //   {
    //     except: ['first-nested'],
    //     ignore: ['between-comments', 'stylelint-commands']
    //   }
    // ],
    // 'scss/double-slash-comment-inline': 'always',
    'scss/double-slash-comment-whitespace-inside': 'always',
    // 'scss/media-feature-value-dollar-variable': 'always',
    // 'scss/operator-no-newline-after': true,
    'scss/operator-no-newline-before': true,
    'scss/operator-no-unspaced': true,
    // 'scss/partial-no-import': true,
    'scss/percent-placeholder-pattern': null,
    'scss/selector-no-redundant-nesting-selector': true,
    // 'selector-attribute-brackets-space-inside': 'never', // stylelint-config-standard
    // 'selector-attribute-operator-blacklist': [],
    // 'selector-attribute-operator-space-after': 'never', // stylelint-config-standard
    // 'selector-attribute-operator-space-before': 'never', // stylelint-config-standard
    // 'selector-attribute-operator-whitelist': [],
    'selector-attribute-quotes': 'always',
    'selector-class-pattern': null,
    // 'selector-combinator-space-after': 'always', // stylelint-config-standard
    // 'selector-combinator-space-before': 'always', // stylelint-config-standard
    // 'selector-descendant-combinator-no-non-space': true, // stylelint-config-standard
    'selector-id-pattern': null,
    // 'selector-list-comma-newline-after': 'always', // stylelint-config-standard
    'selector-list-comma-newline-before': 'never-multi-line',
    'selector-list-comma-space-after': 'always-single-line',
    // 'selector-list-comma-space-before': 'never', // stylelint-config-standard
    'selector-max-attribute': null,
    'selector-max-class': null,
    'selector-max-combinators': null,
    'selector-max-compound-selectors': null,
    // 'selector-max-empty-lines': 0, // stylelint-config-standard
    // 'selector-max-id': 0,
    'selector-max-specificity': null,
    'selector-max-type': null,
    'selector-max-universal': null,
    'selector-nested-pattern': null,
    'selector-no-qualifying-type': null,
    'selector-no-vendor-prefix': null,
    // 'selector-pseudo-class-blacklist': [],
    // 'selector-pseudo-class-case': 'lower', // stylelint-config-standard
    // 'selector-pseudo-class-no-unknown': true, // stylelint-config-recommended
    // 'selector-pseudo-class-parentheses-space-inside': 'never', // stylelint-config-standard
    // 'selector-pseudo-class-whitelist': [],
    // 'selector-pseudo-element-case': 'lower', // stylelint-config-standard
    // 'selector-pseudo-element-colon-notation': 'double', // stylelint-config-standard
    // 'selector-pseudo-element-no-unknown': true, // stylelint-config-recommended
    // 'selector-type-case': 'lower', // stylelint-config-standard
    // 'selector-type-no-unknown': true, // stylelint-config-recommended
    'shorthand-property-no-redundant-values': true,
    // 'string-no-newline': true, // stylelint-config-recommended
    'string-quotes': 'single',
    'time-min-milliseconds': null,
    // 'unit-blacklist': [],
    // 'unit-case': 'lower', // stylelint-config-standard
    // 'unit-no-unknown': true, // stylelint-config-recommended
    // 'unit-whitelist': [],
    'value-keyword-case': 'lower',
    // 'value-list-comma-newline-after': 'always-multi-line', // stylelint-config-standard
    'value-list-comma-newline-before': 'never-multi-line',
    // 'value-list-comma-space-after': 'always-single-line', // stylelint-config-standard
    // 'value-list-comma-space-before': 'never', // stylelint-config-standard
    // 'value-list-max-empty-lines': 0, // stylelint-config-standard
    'value-no-vendor-prefix': null
  }
}
