((document) => {
  // https://github.com/Modernizr/Modernizr/blob/master/feature-detects/dom/dataset.js
  const detect = (createElement) => {
    const n = createElement('div')

    n.setAttribute('data-a-b', 'c')

    return Boolean(n.dataset && n.dataset.aB === 'c')
  }

  if (!document || detect(document.createElement.bind(document))) {
    return
  }

  const replace = (o, s, r) => o.replace(s, r) // eslint-disable-line lodash/prefer-lodash-method
  const toUpper = (o) => o.toUpperCase() // eslint-disable-line lodash/prefer-lodash-method

  const SUBSTR_INDEX = 5
  const descriptor = {}

  descriptor.enumerable = true

  descriptor.get = function __polyfillGet () {
    let i

    const self = this
    const map = {}
    const attrs = self.attributes

    const toUpperCase = (n0) => toUpper(n0.charAt(1))

    const getter = function __polyfillGetter () {
      return this.value // eslint-disable-line babel/no-invalid-this
    }

    const setter = function __polyfillSetter (name, value) {
      if (typeof value === 'undefined') { // eslint-disable-line lodash/prefer-lodash-typecheck
        this.removeAttribute(name) // eslint-disable-line babel/no-invalid-this
      } else {
        this.setAttribute(name, value) // eslint-disable-line babel/no-invalid-this
      }
    }

    for (i = 0; i < attrs.length; ++i) {
      const attr = attrs[i]

      if (!attr || !attr.name || !(/^data-\w[\w-]*$/).test(attr.name)) {
        continue
      }

      const name = attr.name
      const value = attr.value
      const propName = replace(name.substr(SUBSTR_INDEX), /-./g, toUpperCase)

      Object.defineProperty(map, propName, {
        enumerable: descriptor.enumerable,
        get: getter.bind({ value: value || '' }),
        set: setter.bind(self, name)
      })
    }

    return map
  }

  Object.defineProperty(HTMLElement.prototype, 'dataset', descriptor)
})(document)
