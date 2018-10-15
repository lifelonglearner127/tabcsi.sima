<script>
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
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
      ]
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
