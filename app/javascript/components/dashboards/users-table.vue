<script>
import { DateTime } from 'luxon'
import forEach from 'lodash/forEach'
import isEmpty from 'lodash/isEmpty'
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
        {
          key: 'fullName',

          tdClass: (value, key, item) => (this.isDiscarded(item) ? 'discarded-user-name' : null)
        },
        'email',
        'jobTitle',
        'phone',
        'type',
        {
          key: 'pinLastRequestedAt',
          label: 'Logged In'
        },
        {
          key: 'edit',
          label: '',
          tdClass: 'text-center'
        }
      ],
      perPage: 10,
      currentPage: 1,
      totalRows: this.items.length
    }
  },

  mounted () {
    const tdCells = this.$el.querySelectorAll('.discarded-user-name')

    forEach(tdCells, (td) => {
      const row = td.closest('tr')

      row.setAttribute('class', 'text-muted font-italic')
    })
  },

  methods: {
    isDiscarded (user) {
      return !isEmpty(user.discardedAt)
    },

    lastSignInAt (user) {
      return isEmpty(user.pinLastRequestedAt) ? 'Never logged'
        : DateTime.fromISO(user.pinLastRequestedAt).toFormat('LL/dd/yyyy hh:mm')
    },

    userLicenses (user) {
      return map(
        sortBy(user.licenses, ['licenseType', 'licenseNumber']),
        'clp'
      ).join(', ')
    },

    userType (user) {
      return startCase(user.role)
    },

    editUser (user) {
      if (this.isDiscarded(user)) {
        this.$message.error('User has been deleted. Please reactivate/undelete user to edit the user\'s details.')
      } else {
        window.location.href = `/users/${user.id}/edit`
      }
    }
  }
}
</script>

<template>
  <div>
    <b-table
      :fields="fields"
      hover
      :items="items"
      :per-page="perPage"
      :current-page="currentPage"
      :total-rows="totalRows"
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
            fixed-width
            :use="row.detailsShowing ? 'far-fa-minus-square' : 'far-fa-plus-square'"
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
      <template
        slot="pinLastRequestedAt"
        slot-scope="row"
      >
        {{ lastSignInAt(row.item) }}
      </template>
      <a
        slot="edit"
        slot-scope="row"
        title="Edit"
        @click="editUser(row.item)"
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

    <b-pagination
      v-if="totalRows > 0"
      v-model="currentPage"
      :total-rows="totalRows"
      :per-page="perPage"
      class="ml-3 my-3"
    />
  </div>
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
