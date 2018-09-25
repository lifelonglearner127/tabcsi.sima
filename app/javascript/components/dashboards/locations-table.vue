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
          label: 'CLP Numbers'
        },
        'address',
        'phoneNumber',
        {
          key: 'locked',
          label: 'Started',
          tdClass: 'text-center'
        },
        {
          key: 'inspected',
          label: 'Completed',
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
    <template
      slot="locked"
      slot-scope="data"
    >
      <fa-sprite
        v-if="data.value"
        fixed-width
        use="fas-fa-check"
      >
      </fa-sprite>
    </template>
    <template
      slot="inspected"
      slot-scope="data"
    >
      <fa-sprite
        v-if="data.value"
        fixed-width
        use="fas-fa-check"
      >
      </fa-sprite>
    </template>
  </b-table>
</template>

<style lang="scss" scoped>
</style>
