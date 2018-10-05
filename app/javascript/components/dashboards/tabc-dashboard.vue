<script>
import filter from 'lodash/filter'
import isEmpty from 'lodash/isEmpty'
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
    noNewsSelected () {
      return isEmpty(this.selectedNews)
    },

    detailsHref () {
      const firstItem = this.selectedNews[0]

      return firstItem ? `/news/${firstItem.id}` : ''
    },

    editHref () {
      const firstItem = this.selectedNews[0]

      return firstItem ? `/news/${firstItem.id}/edit` : ''
    },

    news () {
      return this.user.news || []
    },

    selectedNews () {
      return filter(this.news, 'selected')
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
            href="/news/new"
            size="sm"
            variant="outline-secondary"
          >
            Add
          </b-button>
          <b-button
            class="mx-1"
            :disabled="noNewsSelected"
            :href="editHref"
            size="sm"
            variant="outline-secondary"
          >
            Edit
          </b-button>
          <b-button
            class="mx-1"
            :disabled="noNewsSelected"
            :href="detailsHref"
            size="sm"
            variant="outline-secondary"
          >
            Details
          </b-button>
        </b-button-toolbar>

        <news-table :items="news" />
      </b-tab>
    </b-tabs>
  </b-card>
</template>

<style lang="scss" scoped>
</style>
