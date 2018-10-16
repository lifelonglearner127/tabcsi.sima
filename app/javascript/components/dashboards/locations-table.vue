<script>
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import forEach from 'lodash/forEach'
import http from '~/lib/http'
import includes from 'lodash/includes'
import isEmpty from 'lodash/isEmpty'
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
    return {
      filteredItems: this.items,
      locationResetDisabled: false,
      searchKey: null,
      searchOption: 'name',
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
        value.push({
          key: 'actions',
          label: '',
          tdClass: 'text-center'
        })
      }

      return value
    }
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
      this.filteredItems = []

      forEach(
        this.items,
        (location) => {
          if (isEmpty(this.searchKey)) {
            this.filteredItems.push(location)

            return
          }

          if (this.searchOption === 'name') {
            if (includes(location.name.toLowerCase(), this.searchKey.toLowerCase())) {
              this.filteredItems.push(location)
            }
          } else if (this.searchOption === 'clp') {
            if (location.clp.toLowerCase() === this.searchKey.toLowerCase()) {
              this.filteredItems.push(location)
            }
          }
        }
      )
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
    <b-button-toolbar
      class="mb-3 ml-3"
    >
      <b-form-input
        v-model="searchKey"
        class="w-25 mx-1"
        size="sm"
      />

      <b-form-select
        v-model="searchOption"
        class="w-auto mx-1"
        :options="searchOptions"
        size="sm"
      />

      <b-button
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
