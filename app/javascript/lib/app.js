import '~/vendor'
import BootstrapVue from 'bootstrap-vue'
import camelCase from 'lodash/camelCase'
import { deepMapKeys } from '~/lib/utils'
import FontAwesome from '~/plugins/font-awesome'
import isFunction from 'lodash/isFunction'
import map from 'lodash/map'
import Sprites from '~/components/sprites'
import Ujs from '~/plugins/ujs'
import Vue from 'vue'

const isDevelopment = process.env.NODE_ENV !== 'production'

Vue.config.devtools = isDevelopment
Vue.config.performance = isDevelopment

Vue.use(FontAwesome)
Vue.use(BootstrapVue)
Vue.use(Ujs)

const onReady = (handler) => {
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', handler)
  } else {
    handler()
  }
}

export default class App {
  static build (pageComponent, _config = {}, _preInit) {
    let config, preInit

    config = _config
    preInit = _preInit
    if (preInit == null && isFunction(config)) {
      preInit = config
      config = {}
    }

    if (isFunction(preInit)) {
      preInit(Vue)
    }

    onReady(() => {
      new Vue({ // eslint-disable-line no-new
        el: 'main',

        data () {
          return {
            defaultPageSlotTemplates: [],
            pageOptions: {}
          }
        },

        beforeCreate () {
          Vue.$rootVm = this
        },

        beforeMount () {
          const pageDataAttr = this.$el.attributes['data-page'] || {}
          const json = JSON.parse(pageDataAttr.value || '{}')

          this.pageOptions = deepMapKeys(json, (value, key) => camelCase(key))
          this.defaultPageSlotTemplates = map(this.$el.children, 'outerHTML')
        },

        render (h) {
          const page = h(
            pageComponent,
            {
              props: { pageOptions: this.pageOptions },
              scopedSlots: { default: () => map(this.defaultPageSlotTemplates, (template) => h({ template })) }
            }
          )

          const sprites = h(Sprites)

          return h('main', { class: 'h-100' }, [page, sprites])
        },

        ...config
      })
    })
  }
}
