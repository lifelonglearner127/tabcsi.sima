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
  <b-container>
    <b-row>
      <b-col>
        <locations-table :items="locations"></locations-table>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
</style>
