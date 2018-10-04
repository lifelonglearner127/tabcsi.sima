<script>
import NewsForm from './form'
import PageMixin from '~/mixins/page'

export default {
  name: 'EditNews',

  components: { NewsForm },

  mixins: [PageMixin],

  data () {
    return {
      news: this.pageOptions.news,
      newsTypes: this.pageOptions.newsTypes
    }
  },

  computed: {},

  methods: {}
}
</script>

<template>
  <news-form
    :accept-charset="acceptCharset"
    :action="action"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :server-errors="serverErrors"
    :token-name="tokenName"
    :token-value="tokenValue"
    :news="news"
    :news-types="newsTypes"
    submit-text="Update"
    title="Update a News"
    back-href="/"
    cols="12"
    show-back-button
    show-top-back-button
    sm="6"
    text-class="font-italic"
  />
</template>

<style lang="scss" scoped>

</style>
