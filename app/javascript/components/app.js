import '~/vendor'
import FontAwesome, { FaSprites } from '~/plugins/font-awesome'
import BootstrapVue from 'bootstrap-vue'
import BootstrapVueUtils from '~/plugins/bootstrap-vue-utils'
import camelCase from 'lodash/camelCase'
import { deepMapKeys } from '~/lib/utils'
import icons from '~/lib/icons'
import isFunction from 'lodash/isFunction'
import map from 'lodash/map'
import Ujs from '~/plugins/ujs'
import Vue from 'vue'
import VueInput from '~/plugins/vue-input'
import Vuelidate from 'vuelidate'

const isDevelopment = process.env.NODE_ENV !== 'production'

Vue.config.devtools = isDevelopment
Vue.config.performance = isDevelopment

FontAwesome.icons(icons)

Vue.use(FontAwesome)
Vue.use(BootstrapVue)
Vue.use(BootstrapVueUtils)
Vue.use(Ujs)
Vue.use(VueInput)
Vue.use(Vuelidate)

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
      // @vue/component
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

          const sprites = h(FaSprites)

          return h('main', { class: 'h-100' }, [page, sprites])
        },

        ...config
      })
    })
  }
}
