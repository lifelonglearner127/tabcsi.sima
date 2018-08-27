<script>
import LocationsTable from './locations-table'

export default {
  name: 'UserDashboard',

  components: { LocationsTable },

  props: {
    user: {
      type: Object,
      required: true
    }
  },

  computed: {
    locations () {
      return this.user.locations || []
    }
  }
}
</script>

<template>
  <locations-table :items="locations"></locations-table>
</template>

<style lang="scss" scoped>
</style>
