import { ICON_MAP, VARIANT_INFO } from './variants'
import Popup from './popup-component'

const DEFAULT_DURATION = 3000

export default {
  components: { Popup },

  data () {
    return {
      customClass: null,
      dangerouslyUseHTMLString: false,
      dismissible: true,
      duration: DEFAULT_DURATION,
      iconOptions: null,
      message: '',
      onClick: null,
      onClose: null,
      variant: VARIANT_INFO,
      visible: false
    }
  },

  computed: {
    icon () {
      return this.iconOptions || ICON_MAP[this.variant]
    }
  },

  mounted () {
    document.addEventListener('keydown', this.onKeyDown)
  },

  destroyed () {
    document.removeEventListener('keydown', this.onKeyDown)
  },

  methods: {
    destroyElement () {
      this.$el.removeEventListener('transitionend', this.destroyElement)
      this.$destroy(true)
      this.$el.parentNode.removeChild(this.$el)
    },

    handleClosed (value) {
      if (!value) {
        return
      }

      this.$el.addEventListener('transitionend', this.destroyElement)

      this.visible = false
    }
  }
}
