<script>
import NewsForm from '~/components/news-form'
import PageMixin from '~/mixins/page'

export default {
  name: 'NewNews',

  components: { NewsForm },

  mixins: [PageMixin],

  data () {
    return {
      news: {
        newsType: 'featured',
        subject: '',
        content: ''
      },
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
    submit-text="Submit"
    title="Create News"
    :token-name="tokenName"
    :token-value="tokenValue"
  />
</template>

<style lang="scss" scoped>
@media only screen and (min-height: 968px) {
  /deep/ .container-row {
    align-items: center;
  }
}
</style>
