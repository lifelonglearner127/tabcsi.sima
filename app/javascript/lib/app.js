import '~/vendor'
import BootstrapVue from 'bootstrap-vue'
import FontAwesome from '~/plugins/font-awesome'
import isFunction from 'lodash/isFunction'
import map from 'lodash/map'
import Sprites from '~/components/sprites'
import Vue from 'vue'

const isDevelopment = process.env.NODE_ENV !== 'production'

Vue.config.devtools = isDevelopment
Vue.config.performance = isDevelopment

Vue.use(FontAwesome)
Vue.use(BootstrapVue)

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

    document.addEventListener('DOMContentLoaded', () => {
      new Vue({ // eslint-disable-line no-new
        el: 'main',

        data () {
          return { defaultPageSlotTemplates: [] }
        },

        beforeCreate () {
          Vue.$rootVm = this
        },

        beforeMount () {
          this.defaultPageSlotTemplates = map(this.$el.children, 'outerHTML')
        },

        render (h) {
          const page = h(
            pageComponent,
            { scopedSlots: { default: () => map(this.defaultPageSlotTemplates, (template) => h({ template })) } }
          )

          const sprites = h(Sprites)

          return h('main', [page, sprites])
        },

        ...config
      })
    })
  }
}
