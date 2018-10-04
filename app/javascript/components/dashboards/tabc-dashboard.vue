<script>
import filter from 'lodash/filter'
import NewsTable from './news-table'

export default {
  name: 'TabcDashboard',

  components: { NewsTable },

  props: {
    user: {
      type: Object,
      required: true
    }
  },

  computed: {
    news () {
      return this.user.news || []
    }
  },

  methods: {
    selectedNews () {
      return filter(this.news, 'selected')
    },
    editNews () {
      const curNews = this.selectedNews()

      if (curNews.length !== 0) {
        window.location.href = `/news/${curNews[0].id}/edit`
      }
    },
    detailNews () {
      const curNews = this.selectedNews()

      if (curNews.length !== 0) {
        window.location.href = `/news/${curNews[0].id}`
      }
    }
  }
}
</script>

<template>
  <b-card no-body>
    <b-tabs card>
      <b-tab active>
        <template slot="title">
          News
        </template>

        <b-button-toolbar
          class="mb-1 mt-4"
          key-nav
        >
          <b-button
            class="mx-1"
            size="sm"
            variant="outline-secondary"
            href="/news/new"
          >
            Add
          </b-button>
          <b-button
            class="mx-1"
            size="sm"
            variant="outline-secondary"
            @click="editNews"
          >
            Edit
          </b-button>
          <b-button
            class="mx-1"
            size="sm"
            variant="outline-secondary"
            @click="detailNews"
          >
            Detail
          </b-button>
        </b-button-toolbar>

        <news-table :items="news"></news-table>
      </b-tab>
    </b-tabs>
  </b-card>
</template>

<style lang="scss" scoped>
</style>
