<script>
import DashboardTable from './dashboard-table'
import { DateTime } from 'luxon'
import { formatDateTime } from '~/lib/utils'
import http from '~/lib/http'

const SEPTEMBER = 9
const RELOAD_DELAY = 1000

export default {
  name: 'ReportsTable',

  components: { DashboardTable },

  props: {
    fiscalYears: {
      type: Array,
      required: true
    },
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      fields: [
        'generatedBy',
        {
          key: 'fiscalYear',
          thClass: 'text-center',
          tdClass: 'text-center'
        },
        {
          key: 'includeReceived',
          label: 'Includes Received?',
          thClass: 'text-center',
          tdClass: 'text-center'
        },
        {
          key: 'updatedAt',
          thClass: 'text-center',
          tdClass: 'text-right'
        },
        {
          key: 'download',
          label: '',
          tdClass: 'text-center'
        }
      ],
      fiscalYear: null,
      generateButtonDisabled: false,
      includeReceived: false
    }
  },

  computed: {
    currentFiscalYear () {
      const now = DateTime.local()
      const startOfFiscalYear = DateTime.local(now.year, SEPTEMBER, 1)

      return now.year + (now < startOfFiscalYear ? 0 : 1)
    }
  },

  mounted () {
    this.fiscalYear = this.currentFiscalYear
  },

  methods: {
    generateReport () {
      if (this.generateButtonDisabled) {
        return
      }

      this.generateButtonDisabled = true

      http
        .post('/reports', {
          report: {
            includeReceived: this.includeReceived,
            fiscalYear: this.fiscalYear
          }
        })
        .then(() => {
          this.$message.success('Report is being generated.')
          setTimeout(() => window.location.reload(true), RELOAD_DELAY)
        })
        .catch(() => {
          this.$message.error(
            'There was an error while trying to generate the report.'
          )

          setTimeout(() => window.location.reload(true), RELOAD_DELAY)
        })
    },

    updatedAt (value) {
      return formatDateTime(value)
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar class="align-items-center justify-content-center mb-3">
      <b-form-select
        id="report_fiscal_year"
        v-model="fiscalYear"
        class="mr-2 w-auto"
        :options="fiscalYears"
      />

      <b-form-checkbox
        id="report_include_received"
        v-model="includeReceived"
        class="mx-2 w-auto"
      >
        Include Received?
      </b-form-checkbox>

      <b-button
        class="ml-2"
        :disabled="generateButtonDisabled"
        size="sm"
        variant="outline-primary"
        @click="generateReport"
      >
        Generate
      </b-button>
    </b-button-toolbar>

    <dashboard-table
      :fields="fields"
      :items="items"
      table-class="reports-table"
    >
      <template slot="table-colgroup">
        <col class="generated-by-col">
        <col class="fiscal-year-col">
        <col class="include-received-col">
        <col class="updated-at-col">
        <col class="download-col">
      </template>

      <template
        slot="includeReceived"
        slot-scope="row"
      >
        {{ row.value ? 'Yes' : 'No' }}
      </template>

      <template
        slot="updatedAt"
        slot-scope="row"
      >
        {{ updatedAt(row.value) }}
      </template>

      <b-button
        slot="download"
        slot-scope="row"
        :disabled="row.item.downloadPath == null"
        :href="row.item.downloadPath"
        size="sm"
        variant="info"
        @click.stop
      >
        Download
      </b-button>
    </dashboard-table>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

.generated-by-col {
  width: auto;
}

.fiscal-year-col {
  @include fixed-width(7rem);
}

.include-received-col {
  @include fixed-width(11rem);
}

.updated-at-col {
  @include fixed-width(12rem);
}

.download-col {
  @include fixed-width(7rem);
}

/deep/ .reports-table {
  table {
    min-width: 718px;
  }
}
</style>
