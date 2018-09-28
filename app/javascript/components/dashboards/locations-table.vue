<script>
import compact from 'lodash/compact'
import map from 'lodash/map'

export default {
  name: 'LocationsTable',

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
          label: '',
          tdClass: 'text-center'
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
        return 'C'
      }

      if (location.locked) {
        return 'S'
      }

      return ''
    },

    statusTitle (location) {
      if (location.inspected) {
        return 'Completed'
      }

      if (location.locked) {
        return 'Started'
      }

      return ''
    }
  }
}
</script>

<template>
  <b-table
    :fields="fields"
    :items="items"
    hover
    responsive
    striped
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
      slot-scope="data"
      v-html="licenses(data.item)"
    />
    <address
      slot="address"
      slot-scope="data"
      v-html="address(data.item)"
    />
    <h3
      slot="status"
      slot-scope="data"
    >
      <abbr :title="statusTitle(data.item)">{{ status(data.item) }}</abbr>
    </h3>
  </b-table>
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
  @include fixed-width(3rem);
}

/deep/ td {
  vertical-align: middle;
}

/deep/ .status-cell {
  text-align: center;

  h3 {
    margin-bottom: 0;
  }
}
</style>
