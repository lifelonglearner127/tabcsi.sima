<script>
import PageMixin from '~/mixins/page'
import TabcCard from '~/components/tabc-card'

export default {
  name: 'ShowNews',

  components: { TabcCard },

  mixins: [PageMixin],

  data () {
    return { news: this.pageOptions.news }
  }
}
</script>

<template>
  <tabc-card
    cols="12"
    md="6"
    sm="9"
    :title="news.subject"
  >
    <div
      class="news-content"
      v-html="news.content"
    />
  </tabc-card>
</template>

<style lang="scss" scoped>
/deep/ .news-content {
  img {
    height: auto;
    max-width: 100%;
  }
}
</style>
