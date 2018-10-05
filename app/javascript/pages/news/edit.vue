<script>
import NewsForm from '~/components/news-form'
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
  }
}
</script>

<template>
  <news-form
    :accept-charset="acceptCharset"
    :action="action"
    back-href="/"
    cols="12"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :server-errors="serverErrors"
    :token-name="tokenName"
    :token-value="tokenValue"
    :news="news"
    :news-types="newsTypes"
    show-back-button
    show-top-back-button
    sm="6"
    submit-text="Update"
    text-class="font-italic"
    title="Update a News"
  />
</template>

<style lang="scss" scoped>
</style>
