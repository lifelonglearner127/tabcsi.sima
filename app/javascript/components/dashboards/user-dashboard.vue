<script>
import LocationsTable from './locations-table'

export default {
  name: 'UserDashboard',

  components: { LocationsTable },

  props: {
    locations: {
      type: Array,

      default () {
        return []
      }
    },
    user: {
      type: Object,
      required: true
    }
  }
}
</script>

<template>
  <locations-table :items="locations"></locations-table>
</template>

<style lang="scss" scoped>
</style>
