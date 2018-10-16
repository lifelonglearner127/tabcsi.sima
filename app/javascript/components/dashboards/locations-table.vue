<script>
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import forEach from 'lodash/forEach'
import includes from 'lodash/includes'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'

export default {
  name: 'LocationsTable',

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
      ],
      filteredItems: this.items,
      searchOptions: [
        {
          text: 'Name (Company name)',
          value: 'name'
        },
        {
          text: 'CLP Number',
          value: 'clp'
        }
      ],
      searchOption: 'name',
      searchKey: null
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

    licenses (location) {
      return map(location.licenses, (license) => [
        license.licenseType,
        license.licenseNumber
      ].join('')).join('<br>')
    },

    status (location) {
      if (location.inspected) {
        return `Completed by ${location.inspectedBy.fullName}`
      }

      if (location.locked) {
        return `Started by ${location.lockedBy.fullName}`
      }

      return ''
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
      />

      <b-form-select
        v-model="searchOption"
        :options="searchOptions"
        class="w-25 mx-1"
      />

      <b-btn
        variant="outline-secondary"
        @click="filterLocations"
      >
        Search
      </b-btn>
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
  @include fixed-width(7rem);
}

/deep/ .status-cell {
  text-align: center;

  h3 {
    margin-bottom: 0;
  }
}
</style>
