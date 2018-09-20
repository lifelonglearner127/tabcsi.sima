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
      return 'dataRemote' in this.pageOptions && Boolean(this.pageOptions.dataRemote)
    },

    encodingType () {
      return this.pageOptions.enctype
    },

    enforceUtf8 () {
      return 'enforceUtf8' in this.pageOptions && Boolean(this.pageOptions.enforceUtf8)
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
      return 'multipart' in this.pageOptions && Boolean(this.pageOptions.multipart)
    },

    serverErrors () {
      return this.pageOptions.errors || {}
    },

    flashMessage () {
      return this.pageOptions.flashMessage || ''
    },

    tokenName () {
      return this.authenticityToken.name
    },

    tokenValue () {
      return this.authenticityToken.value
    }
  }
}
