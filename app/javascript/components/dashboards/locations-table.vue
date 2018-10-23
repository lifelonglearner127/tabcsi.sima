<script>
import { addSearchedItem, filterItems } from '~/lib/utils'
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import http from '~/lib/http'
import map from 'lodash/map'

export default {
  name: 'LocationsTable',

  components: { DashboardTable },

  props: {
    isTabcAdmin: Boolean,
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    const obj = {
      filteredItems: this.items,
      locationResetDisabled: false,
      searchKey: null,
      searchOption: null,
      searchOptions: [
        {
          text: 'Name',
          value: 'name'
        },
        {
          text: 'CLP Number',
          value: 'clp'
        }
      ]
    }

    if (this.isTabcAdmin) {
      obj.searchOptions.unshift({
        text: 'Company Name',
        value: 'company'
      })
    }

    return obj
  },

  computed: {
    fields () {
      const value = [
        'name',
        {
          key: 'clp',
          label: 'CLP Number'
        },
        'address',
        'phoneNumber',
        {
          key: 'status',
          tdClass: 'text-center',
          thClass: 'text-center'
        }
      ]

      if (this.isTabcAdmin) {
        value.unshift('company')

        value.push({
          key: 'actions',
          label: '',
          tdClass: 'text-center'
        })
      }

      return value
    },

    firstColumnSlot () {
      return this.isTabcAdmin ? 'company' : 'fullName'
    }
  },

  mounted () {
    this.searchOption = this.firstColumnSlot
  },

  methods: {
    address (location) {
      return compact([
        location.address1,
        location.address2,
        location.address3,
        compact([
          location.city,
          location.county,
          location.state,
          location.postalCode
        ]).join(' '),
        location.country
      ]).join('<br>')
    },

    filterLocations () {
      this.filteredItems = filterItems(this.items, this.searchKey, (filteredItems, item, value) => {
        switch (this.searchOption) {
          case 'company':
            addSearchedItem(filteredItems, item, value, ['company.name', 'company.ownerName'])
            break

          case 'name':
            addSearchedItem(filteredItems, item, value, 'name')
            break

          case 'clp':
            addSearchedItem(filteredItems, item, value, 'clp')
            break

          // no default
        }
      })
    },

    firstColumnValue (row) {
      if (this.isTabcAdmin) {
        if (row.value == null) {
          return 'TABC'
        }

        return row.value.name || row.value.ownerName
      }

      return row.value
    },

    licenses (location) {
      return map(location.licenses, (license) => [
        license.licenseType,
        license.licenseNumber
      ].join('')).join('<br>')
    },

    resetDisabled (location) {
      return this.locationResetDisabled || !location.locked || location.inspected
    },

    resetLocation (location) {
      if (this.locationResetDisabled) {
        return
      }

      this.locationResetDisabled = true

      const locationInfo = `${location.name} (${location.address1})`

      this
        .$confirm(
          `Are you sure you want to reset the location ${locationInfo}?`,
          'Reset Location',
          {
            closeButtonAlias: 'no',
            variant: 'error'
          }
        )
        .yes(() => {
          this
            .$confirm(
              `Are you absolutely sure you want to reset the location ${locationInfo}? This cannot be undone.`,
              'Reset Location',
              {
                closeButtonAlias: 'no',
                variant: 'error'
              }
            )
            .yes(() => {
              http
                .post(`/locations/${location.id}/reset`)
                .then(() => {
                  this.$message.success('The location was successfully reset.')

                  this.$nextTick(() => {
                    window.location.reload(true)
                  })
                })
                .catch(() => {
                  this.$message.error('There was a problem resetting the location.')

                  this.locationResetDisabled = false
                })
            })
            .no(() => {
              this.locationResetDisabled = false
            })
        })
        .no(() => {
          this.locationResetDisabled = false
        })
    },

    status (location) {
      if (location.locked) {
        return `Started by ${location.lockedBy.fullName}`
      }

      if (location.inspected) {
        return `Completed by ${location.inspectedBy.fullName}`
      }

      return ''
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar class="mb-3 mr-3 justify-content-end">
      <b-form-input
        v-model="searchKey"
        class="mr-1 w-25"
        size="sm"
        @keydown.enter.native="filterLocations"
      />

      <b-form-select
        v-model="searchOption"
        class="mx-1 w-auto"
        :options="searchOptions"
        size="sm"
      />

      <b-button
        class="ml-1"
        size="sm"
        variant="outline-secondary"
        @click="filterLocations"
      >
        Search
      </b-button>
    </b-button-toolbar>

    <dashboard-table
      :fields="fields"
      :items="filteredItems"
    >
      <template slot="table-colgroup">
        <col
          v-if="isTabcAdmin"
          class="company-col"
        >
        <col class="name-col">
        <col class="clp-col">
        <col class="address-col">
        <col class="phone-col">
        <col class="status-col">
        <col
          v-if="isTabcAdmin"
          class="actions-col"
        >
      </template>

      <template
        :slot="firstColumnSlot"
        slot-scope="row"
      >
        {{ firstColumnValue(row) }}
      </template>

      <div
        slot="clp"
        slot-scope="row"
        v-html="licenses(row.item)"
      />

      <address
        slot="address"
        slot-scope="row"
        v-html="address(row.item)"
      />

      <h6
        slot="status"
        slot-scope="row"
      >
        {{ status(row.item) }}
      </h6>

      <b-button
        v-if="isTabcAdmin"
        slot="actions"
        slot-scope="row"
        :disabled="resetDisabled(row.item)"
        size="sm"
        variant="danger"
        @click="resetLocation(row.item)"
      >
        Reset
      </b-button>
    </dashboard-table>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

.company-col {
  width: auto;
}

.name-col {
  width: auto;
}

.clp-col {
  @include fixed-width(8rem);
}

.address-col {
  width: auto;
}

.phone-col {
  @include fixed-width(10rem);
}

.status-col {
  width: auto;
}

.actions-col {
  @include fixed-width(5rem);
}

/deep/ .status-cell {
  text-align: center;

  h3 {
    margin-bottom: 0;
  }
}
</style>
