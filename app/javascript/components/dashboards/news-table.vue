<script>
import capitalize from 'lodash/capitalize'
import DashboardTable from './dashboard-table'
import { DateTime } from 'luxon'

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
      selectedNews: {}
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

    newsType (value) {
      return capitalize(value)
    },

    viewNews (news) {
      this.selectedNews = news

      this.$refs.viewModal.show()
    }
  }
}
</script>

<template>
  <dashboard-table
    :fields="fields"
    :items="items"
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
</style>
