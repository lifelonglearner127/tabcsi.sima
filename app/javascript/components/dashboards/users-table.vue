<script>
import chunk from 'lodash/chunk'
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import forEach from 'lodash/forEach'
import { formatDateTime } from '~/lib/utils'
import includes from 'lodash/includes'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import sortBy from 'lodash/sortBy'
import startCase from 'lodash/startCase'

const DISPLAY_BOXES_PER_ROW = 6

const buildCheckboxField = (self, key) => {
  const tdClassFunc = function _tdClassFunc (value, _key, item) {
    const classes = ['first-column']

    if (this.isDiscarded(item)) {
      classes.push('user-discarded')
    }

    return classes
  }

  return {
    key,
    tdClass: tdClassFunc.bind(self)
  }
}

export default {
  name: 'UsersTable',

  components: { DashboardTable },

  props: {
    currentUser: {
      type: Object,
      required: true
    },
    items: {
      type: Array,
      required: true
    }
  },

  data () {
    return {
      filteredItems: this.items,
      searchOptions: [
        {
          text: 'Company name',
          value: 'company'
        },
        {
          text: 'Full Name ',
          value: 'fullName'
        },
        {
          text: 'Email',
          value: 'email'
        }
      ],
      searchKey: null
    }
  },

  computed: {
    currentUserIsTabc () {
      return this.isTabc(this.currentUser)
    },

    searchOption () {
      return this.currentUserIsTabc ? 'company' : 'fullName'
    },

    fields () {
      const result = [
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
      ]

      if (this.currentUserIsTabc) {
        result.unshift('fullName')
        result.unshift(buildCheckboxField(this, 'company'))
      } else {
        result.unshift(buildCheckboxField(this, 'fullName'))
      }

      return result
    },

    firstColumnSlot () {
      return this.currentUserIsTabc ? 'company' : 'fullName'
    }
  },

  mounted () {
    const tdCells = this.$el.querySelectorAll('.user-discarded')

    forEach(tdCells, (td) => {
      const row = td.closest('tr')

      row.setAttribute('class', 'text-muted font-italic')
    })
  },

  methods: {
    editUser (user) {
      if (this.isDiscarded(user)) {
        this.$message.error('User has been deleted. Please reactivate/undelete user to edit the user\'s details.')
      } else {
        window.location.href = `/users/${user.id}/edit`
      }
    },

    firstColumnValue (row) {
      if (this.currentUserIsTabc) {
        return row.value == null ? 'TABC' : row.value.name
      }

      return row.value
    },

    isDiscarded (user) {
      return !isEmpty(user.discardedAt)
    },

    isTabc (user) {
      return user.role === 'tabc'
    },

    lastSignInAt (user) {
      return isEmpty(user.pinLastRequestedAt) ? 'Never logged in.' : formatDateTime(user.pinLastRequestedAt)
    },

    locationAddress (location) {
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
      ]).join(', ')
    },

    userLicensesByChunk (user) {
      return chunk(
        map(
          sortBy(user.licenses, ['licenseType', 'licenseNumber']),
          (license) => compact([
            license.location.name,
            this.locationAddress(license.location),
            license.clp
          ]).join('<br>')
        ), DISPLAY_BOXES_PER_ROW)
    },

    userType (user) {
      return startCase(user.role)
    },

    filterUsers () {
      this.filteredItems = []
      forEach(
        this.items,
        (user) => {
          if (isEmpty(this.searchKey)) {
            this.filteredItems.push(user)

            return
          }

          switch (this.searchOption) {
            case 'company':
              if (includes(user.company.name.toLowerCase(), this.searchKey.toLowerCase())) {
                this.filteredItems.push(user)
              }

              break
            case 'fullName':
              if (includes(user.fullName.toLowerCase(), this.searchKey.toLowerCase())) {
                this.filteredItems.push(user)
              }

              break
            case 'email':
              if (user.email === this.searchKey) {
                this.filteredItems.push(user)
              }

              break
            default:
              this.filteredItems = user
          }
        }
      )
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar
      class="mb-3 ml-3"
    >
      <b-form-input
        v-model="searchKey"
        size="sm"
        class="w-25 mx-1"
      />

      <b-form-select
        v-model="searchOption"
        :options="searchOptions"
        size="sm"
        class="w-25 mx-1"
      />

      <b-btn
        variant="outline-secondary"
        size="sm"
        @click="filterUsers"
      >
        Search
      </b-btn>
    </b-button-toolbar>

    <dashboard-table
      :fields="fields"
      :items="filteredItems"
    >
      <template slot="table-colgroup">
        <col
          v-if="currentUserIsTabc"
          class="company-col"
        >
        <col class="full-name-col">
        <col class="email-col">
        <col class="job-title-col">
        <col class="phone-col">
        <col class="type-col">
        <col class="logged-in-col">
        <col class="edit-col">
      </template>

      <template
        :slot="firstColumnSlot"
        slot-scope="row"
      >
        <a
          v-if="!isTabc(row.item)"
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
          :disabled="row.item.id === currentUser.id"
        >
          {{ firstColumnValue(row) }}
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
        href="#"
        title="Edit"
        @click.prevent="editUser(row.item)"
      >
        <fa-sprite
          fixed-width
          use="fas-fa-user-edit"
        />
      </a>

      <b-container
        v-if="!isTabc(row.item)"
        slot="row-details"
        slot-scope="row"
        fluid
      >
        <b-row>
          <b-col class="col-shrink">
            <b-card header="Licenses/Permits">
              <div
                v-for="(chunk, chunkIndex) in userLicensesByChunk(row.item)"
                :key="chunkIndex"
                class="d-flex"
              >
                <div
                  v-for="(license, licenseIndex) in chunk"
                  :key="licenseIndex"
                  class="license-box"
                >
                  <p v-html="license" />
                </div>
              </div>
            </b-card>
          </b-col>
        </b-row>
      </b-container>
    </dashboard-table>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

.company-col {
  width: auto;
}

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

.logged-in-col {
  @include fixed-width(12.5rem);
}

.edit-col {
  @include fixed-width(3rem);
}

/deep/ .first-column {
  > .custom-checkbox:first-child {
    margin-left: 1.5625rem;
  }
}

.license-box {
  border: 1px solid gray;
  margin: 0 5px 5px 0;
  padding: 0.5rem
}
</style>
