<script>
import capitalize from 'lodash/capitalize'
import { DateTime } from 'luxon'

export default {
  name: 'NewsTable',

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
      selectedNews: {},
      perPage: 10,
      currentPage: 1,
      totalRows: this.items.length
    }
  },

  computed: {
    newsSrc () {
      return this.selectedNews.id == null ? 'about:blank' : `/news/${this.selectedNews.id}`
    }
  },

  methods: {
    formatTimestamp (timestamp) {
      return DateTime.fromISO(timestamp).toFormat('M/d/yyyy h:mm a')
    },

    viewNews (news) {
      this.selectedNews = news

      this.$refs.viewModal.show()
    },

    capitalizeNewsType (newsType) {
      return capitalize(newsType)
    }
  }
}
</script>

<template>
  <div>
    <b-table
      :current-page="currentPage"
      :fields="fields"
      hover
      :items="items"
      :per-page="perPage"
      responsive
      striped
      :total-rows="totalRows"
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
        slot-scope="data"
      >
        <b-form-checkbox
          :id="`news_${data.index}_selected`"
          v-model="data.item.selected"
        >
          {{ capitalizeNewsType(data.value) }}
        </b-form-checkbox>
      </template>

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
        {{ formatTimestamp(row.item.updatedAt) }}
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
    </b-table>

    <b-pagination
      v-if="totalRows > 0"
      v-model="currentPage"
      :total-rows="totalRows"
      :per-page="perPage"
      class="ml-3 my-3"
    />

    <b-modal
      ref="viewModal"
      centered
      ok-only
      size="lg"
      title="View News"
    >
      <iframe :src="newsSrc" />
    </b-modal>
  </div>
</template>

<style lang="scss" scoped>
.news-type-col {
  width: 8.25rem;
}

.subject-col {
  width: auto;
}

.created-by-col {
  width: auto;
}

.updated-at-col {
  width: 12.5rem;
}

.actions-col {
  width: 4.75rem;
}

.modal {
  iframe {
    height: 50vh;
    width: 100%;
  }
}
</style>
