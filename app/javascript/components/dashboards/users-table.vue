<script>
import map from 'lodash/map'
import sortBy from 'lodash/sortBy'
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
    userLicenses (user) {
      return map(
        sortBy(user.licenses, ['licenseType', 'licenseNumber']),
        'clp'
      ).join(', ')
    },

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
    <template
      slot="fullName"
      slot-scope="row"
    >
      <a
        href="#"
        @click.prevent.stop="row.toggleDetails"
      >
        <fa-sprite
          :use="row.detailsShowing ? 'far-fa-minus-square' : 'far-fa-plus-square'"
          fixed-width
        />
      </a>
      <b-form-checkbox
        :id="`user_${row.index}_selected`"
        v-model="row.item.selected"
        :disabled="row.item.id === currentUserId"
      >
        {{ row.value }}
      </b-form-checkbox>
    </template>
    <template
      slot="type"
      slot-scope="row"
    >
      {{ userType(row.item) }}
    </template>
    <a
      slot="edit"
      slot-scope="row"
      :href="`/users/${row.item.id}/edit`"
      title="Edit"
    >
      <fa-sprite
        fixed-width
        use="fas-fa-user-edit"
      />
    </a>
    <b-container
      slot="row-details"
      slot-scope="row"
      fluid
    >
      <b-row>
        <b-col class="col-shrink">
          <b-card header="Licenses/Permits">
            {{ userLicenses(row.item) }}
          </b-card>
        </b-col>
      </b-row>
    </b-container>
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
