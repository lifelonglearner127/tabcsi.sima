export default {
  props: {
    pageData: {
      type: Object,

      default () {
        return {}
      }
    }
  },

  computed: {
    acceptCharset () {
      return this.pageData.acceptCharset
    },

    action () {
      return this.pageData.action
    },

    authenticityToken () {
      return this.pageData.authenticityToken || {}
    },

    enforceUtf8 () {
      return 'enforceUtf8' in this.pageData
    },

    hiddenMethod () {
      return this.pageData.hiddenMethod
    },

    method () {
      return this.pageData.method
    },

    tokenName () {
      return this.authenticityToken.name
    },

    tokenValue () {
      return this.authenticityToken.value
    }
  }
}
