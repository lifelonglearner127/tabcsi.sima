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
        <locations-table :items="locations" />
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.table-responsive {
  border: $card-border-width solid $card-border-color;
  border-top-width: 0;

  /deep/ .table {
    margin-bottom: 0;
  }
}
</style>
