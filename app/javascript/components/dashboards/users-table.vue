<script>
import startCase from 'lodash/startCase'

export default {
  name: 'UsersTable',

  props: {
    currentUserId: {
      type: Number,
      required: true
    },
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
        'type',
        {
          key: 'edit',
          label: '',
          tdClass: 'text-center'
        }
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
    <template slot="table-colgroup">
      <col class="full-name-col">
      <col class="email-col">
      <col class="job-title-col">
      <col class="phone-col">
      <col class="type-col">
      <col class="edit-col">
    </template>
    <b-form-checkbox
      :id="`user_${data.index}_selected`"
      slot="fullName"
      v-model="data.item.selected"
      slot-scope="data"
      :disabled="data.item.id === currentUserId"
    >
      {{ data.value }}
    </b-form-checkbox>
    <template
      slot="type"
      slot-scope="data"
    >
      {{ userType(data.item) }}
    </template>
    <a
      slot="edit"
      slot-scope="data"
      :href="`/users/${data.item.id}/edit`"
      title="Edit"
    >
      <fa-sprite
        fixed-width
        use="fas-fa-user-edit"
      />
    </a>
  </b-table>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

.full-name-col {
  width: auto;
}

.email-col {
  width: auto;
}

.job-title-col {
  width: auto;
}

.phone-col {
  @include fixed-width(10rem);
}

.type-col {
  @include fixed-width(5rem);
}

.edit-col {
  @include fixed-width(3rem);
}
</style>
