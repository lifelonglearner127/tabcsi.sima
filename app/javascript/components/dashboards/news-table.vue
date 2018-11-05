<script>
import capitalize from 'lodash/capitalize'
import DashboardTable from './dashboard-table'
import filter from 'lodash/filter'
import { formatDateTime } from '~/lib/utils'
import http from '~/lib/http'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'

export default {
  name: 'NewsTable',

  components: { DashboardTable },

  props: {
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      fields: [
        'newsType',
        'subject',
        {
          key: 'createdBy',
          label: 'Created By'
        },
        {
          key: 'updatedAt',
          label: 'Updated At'
        },
        {
          key: 'actions',
          label: '',
          tdClass: 'text-center'
        }
      ],
      selectedNewsItem: {}
    }
  },

  computed: {
    multipleNewsSelected () {
      return this.selectedNews.length > 1
    },

    newsEditHref () {
      const firstItem = this.selectedNews[0]

      return firstItem ? `/news/${firstItem.id}/edit` : ''
    },

    newsSrc () {
      return this.selectedNewsItem.id == null ? 'about:blank' : `/news/${this.selectedNewsItem.id}`
    },

    noNewsSelected () {
      return isEmpty(this.selectedNews)
    },

    selectedNews () {
      return filter(this.items, 'selected')
    }
  },

  methods: {
    deleteNews () {
      this
        .$confirm(
          'Are you sure you want to delete the selected news?',
          'Delete News',
          { variant: 'error' }
        )
        .yes(() => {
          Promise
            .all(
              map(
                this.selectedNews,
                (news) => http
                  .delete(`/news/${news.id}`)
                  .then(() => {
                    this.$message.success(`News "${news.subject}" deleted.`)
                  })
              )
            )
            .then(() => {
              window.location.reload(true)
            })
        })
    },

    newsType (value) {
      return capitalize(value)
    },

    updatedAt (value) {
      return formatDateTime(value)
    },

    viewNews (news) {
      this.selectedNewsItem = news

      this.$refs.viewModal.show()
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar class="mb-3 ml-3">
      <b-button
        class="mr-1"
        href="/news/new"
        size="sm"
        variant="outline-secondary"
      >
        Create
      </b-button>

      <b-button
        class="mx-1"
        :disabled="noNewsSelected || multipleNewsSelected"
        :href="newsEditHref"
        size="sm"
        variant="outline-secondary"
      >
        Edit
      </b-button>

      <b-button
        class="ml-1"
        :disabled="noNewsSelected"
        size="sm"
        variant="outline-secondary"
        @click.prevent="deleteNews"
      >
        Delete
      </b-button>
    </b-button-toolbar>

    <dashboard-table
      :fields="fields"
      :items="items"
      class="news-table"
    >
      <template slot="table-colgroup">
        <col class="news-type-col">
        <col class="subject-col">
        <col class="created-by-col">
        <col class="updated-at-col">
        <col class="actions-col">
      </template>

      <template
        slot="newsType"
        slot-scope="row"
      >
        <b-form-checkbox
          :id="`news_${row.index}_selected`"
          v-model="row.item.selected"
        >
          {{ newsType(row.value) }}
        </b-form-checkbox>
      </template>

      <div
        slot="subject"
        slot-scope="row"
        class="text-ellipsis"
      >
        {{ row.value }}
      </div>

      <template
        slot="createdBy"
        slot-scope="row"
      >
        {{ row.item.user.fullName }}
      </template>

      <template
        slot="updatedAt"
        slot-scope="row"
      >
        {{ updatedAt(row.item.updatedAt) }}
      </template>

      <b-button
        slot="actions"
        slot-scope="row"
        size="sm"
        variant="info"
        @click="viewNews(row.item)"
      >
        View
      </b-button>

      <b-modal
        ref="viewModal"
        centered
        ok-only
        size="lg"
        title="View News"
      >
        <iframe :src="newsSrc" />
      </b-modal>
    </dashboard-table>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

.news-type-col {
  @include fixed-width(8.25rem);
}

.subject-col {
  width: auto;
}

.created-by-col {
  width: auto;
}

.updated-at-col {
  @include fixed-width(12.5rem);
}

.actions-col {
  @include fixed-width(4.75rem);
}

.modal {
  iframe {
    height: 50vh;
    width: 100%;
  }
}

/deep/ .news-table table {
  min-width: 667px;
}
</style>
