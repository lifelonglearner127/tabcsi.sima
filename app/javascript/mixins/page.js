import { getBoolean } from '~/lib/utils'
import isEmpty from 'lodash/isEmpty'

// @vue/component
export default {
  props: {
    pageOptions: {
      type: Object,

      default () {
        return {}
      }
    }
  },

  computed: {
    acceptCharset () {
      return this.pageOptions.acceptCharset
    },

    action () {
      return this.pageOptions.action
    },

    authenticityToken () {
      return this.pageOptions.authenticityToken || {}
    },

    classNames () {
      return this.pageOptions.class
    },

    data () {
      return this.pageOptions.data
    },

    dataRemote () {
      return getBoolean(this.pageOptions, 'dataRemote')
    },

    encodingType () {
      return this.pageOptions.enctype
    },

    enforceUtf8 () {
      return getBoolean(this.pageOptions, 'enforceUtf8')
    },

    flashMessage () {
      return this.pageOptions.flashMessage
    },

    hiddenMethod () {
      return this.pageOptions.hiddenMethod
    },

    id () {
      return this.pageOptions.id
    },

    method () {
      return this.pageOptions.method
    },

    multiPart () {
      return getBoolean(this.pageOptions, 'multipart')
    },

    pageName () {
      return this.pageOptions.pageName
    },

    serverErrors () {
      return this.pageOptions.errors || {}
    },

    tokenName () {
      return this.authenticityToken.name
    },

    tokenValue () {
      return this.authenticityToken.value
    }
  },

  mounted () {
    if (!isEmpty(this.flashMessage)) {
      this.$message({
        message: this.flashMessage,
        type: 'success'
      })
    }
  }
}
