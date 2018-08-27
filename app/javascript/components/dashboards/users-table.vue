<script>
import startCase from 'lodash/startCase'

export default {
  name: 'UsersTable',

  props: {
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      fields: [
        'fullName',
        'email',
        'jobTitle',
        'phone',
        'type'
      ]
    }
  },

  methods: {
    userType (user) {
      return startCase(user.role)
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
    <template
      slot="type"
      slot-scope="data"
    >
      {{ userType(data.item) }}
    </template>
  </b-table>
</template>

<style lang="scss" scoped>
</style>
