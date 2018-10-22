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
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :news="news"
    :news-types="newsTypes"
    :server-errors="serverErrors"
    submit-text="Update"
    title="Update News"
    :token-name="tokenName"
    :token-value="tokenValue"
  />
</template>

<style lang="scss" scoped>
</style>
