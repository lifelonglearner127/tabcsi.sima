<script>
import { DateTime } from 'luxon'
import isEmpty from 'lodash/isEmpty'

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
          label: 'Created by'
        },
        {
          key: 'touchedAt',
          label: 'Time'
        },
        {
          key: 'preview',
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

  methods: {
    createdBy (news) {
      return news.user.fullName
    },

    touchedAt (news) {
      return isEmpty(news.updatedAt) ? DateTime.fromISO(news.updateAt).toFormat('LL/dd/yyyy hh:mm')
        : DateTime.fromISO(news.createdAt).toFormat('LL/dd/yyyy hh:mm')
    },

    previewNews (news) {
      this.selectedNews = news

      this.$refs.previewModal.show()
    }
  }
}
</script>

<template>
  <div>
    <b-table
      :fields="fields"
      hover
      :items="items"
      :per-page="perPage"
      :current-page="currentPage"
      :total-rows="totalRows"
      responsive
      striped
      pagination
    >
      <template
        slot="newsType"
        slot-scope="data"
      >
        <b-form-checkbox
          :id="`news_${data.index}_selected`"
          v-model="data.item.selected"
        >
          {{ data.value }}
        </b-form-checkbox>
      </template>

      <template
        slot="createdBy"
        slot-scope="row"
      >
        {{ createdBy(row.item) }}
      </template>

      <template
        slot="touchedAt"
        slot-scope="row"
      >
        {{ touchedAt(row.item) }}
      </template>

      <b-button
        slot="preview"
        slot-scope="row"
        size="sm"
        variant="info"
        @click="previewNews(row.item)"
      >
        Preview
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
      ref="previewModal"
      ok-only
      size="lg"
      title="Preview News"
    >
      <div v-html="selectedNews.content" />
    </b-modal>
  </div>
</template>

<style lang="scss" scoped>
</style>
