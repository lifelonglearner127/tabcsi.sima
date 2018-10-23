<script>
import { addSearchedItem, formatDateTime } from '~/lib/utils'
import chunk from 'lodash/chunk'
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import filter from 'lodash/filter'
import forEach from 'lodash/forEach'
import http from '~/lib/http'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import sortBy from 'lodash/sortBy'
import startCase from 'lodash/startCase'

const DISPLAY_BOXES_PER_ROW = 6

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
    const obj = {
      filteredItems: this.items,
      searchOptions: [
        {
          text: 'Full Name',
          value: 'fullName'
        },
        {
          text: 'Email',
          value: 'email'
        }
      ],
      searchOption: null,
      searchKey: null
    }

    // `this.currentUserIsTabc` computed property is not available here.
    if (this.isTabc(this.currentUser)) {
      obj.searchOptions.unshift({
        text: 'Company Name',
        value: 'company'
      })
    }

    return obj
  },

  computed: {
    currentUserIsTabc () {
      return this.isTabc(this.currentUser)
    },

    fields () {
      const value = [
        'email',
        'jobTitle',
        'phone',
        'type',
        {
          key: 'pinLastRequestedAt',
          label: 'Logged In'
        },
        {
          key: 'actions',
          label: '',
          tdClass: 'text-center'
        }
      ]

      if (this.currentUserIsTabc) {
        value.unshift('fullName')
      }

      value.unshift({
        key: this.firstColumnSlot,
        tdClass: 'first-column'
      })

      return value
    },

    firstColumnSlot () {
      return this.currentUserIsTabc ? 'company' : 'fullName'
    },

    noDiscardedUsersSelected () {
      return isEmpty(this.selectedDiscardedUsers)
    },

    noUsersSelected () {
      return isEmpty(this.selectedUsers)
    },

    selectedDiscardedUsers () {
      return filter(this.items, (user) => user.selected && this.isDiscarded(user))
    },

    selectedUsers () {
      return filter(this.items, (user) => user.selected && !this.isDiscarded(user))
    }
  },

  mounted () {
    this.searchOption = this.firstColumnSlot
  },

  methods: {
    deleteUsers () {
      this
        .$confirm(
          'Are you sure you want to delete the selected user(s)?',
          'Delete User(s)',
          { variant: 'error' }
        )
        .yes(() => {
          Promise
            .all(
              map(
                this.selectedUsers,
                (user) => http
                  .delete(`/users/${user.id}`)
                  .then(() => {
                    this.$message.success(`User "${user.fullName}" deleted.`)
                  })
              )
            )
            .then(() => {
              window.location.reload(true)
            })
        })
    },

    editUser (user) {
      if (this.isDiscarded(user)) {
        this.$message.error("User has been deleted. Please reactivate/undelete user to edit the user's details.")
      } else {
        window.location.href = `/users/${user.id}/edit`
      }
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
              addSearchedItem(this.searchKey, [user.company.name, user.company.ownerName], this.filteredItems, user)

              break

            case 'fullName':
              addSearchedItem(this.searchKey, user.fullName, this.filteredItems, user)

              break

            case 'email':
              if (this.searchKey === user.email) {
                this.filteredItems.push(user)
              }

              break

            // no default
          }
        }
      )
    },

    firstColumnValue (row) {
      if (this.currentUserIsTabc) {
        if (row.value == null) {
          return 'TABC'
        }

        return row.value.name || row.value.ownerName
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

    undiscardUsers () {
      this
        .$confirm(
          'Are you sure you want to restore the selected user(s)?',
          'Restore User(s)',
          { variant: 'error' }
        )
        .yes(() => {
          Promise
            .all(
              map(
                this.selectedDiscardedUsers,
                (user) => http
                  .post(`/users/${user.id}/undiscard`)
                  .then(() => {
                    this.$message.success(`User "${user.fullName}" restored.`)
                  })
              )
            )
            .then(() => {
              window.location.reload(true)
            })
        })
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
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar
      class="mb-3 mx-3"
      key-nav
    >
      <b-dropdown
        class="mr-1"
        :disabled="currentUserIsTabc"
        size="sm"
        variant="outline-secondary"
      >
        <template slot="button-content">
          <fa-sprite
            fixed-width
            use="fas-fa-user-plus"
          />
          Invite User
        </template>
        <b-dropdown-item
          class="px-3"
          href="/users/invite"
        >
          <fa-sprite
            fixed-width
            use="fas-fa-plus"
          />
          Manual Add
        </b-dropdown-item>
        <b-dropdown-item
          class="px-3"
          disabled
        >
          <fa-sprite
            fixed-width
            use="fas-fa-file-upload"
          />
          Upload CSV (Coming Soon)
        </b-dropdown-item>
      </b-dropdown>

      <b-button
        class="mx-1"
        :disabled="noUsersSelected"
        size="sm"
        variant="outline-secondary"
        @click.prevent="deleteUsers"
      >
        <fa-sprite
          fixed-width
          use="fas-fa-user-times"
        />
        Delete
      </b-button>

      <b-button
        class="ml-1"
        :disabled="noDiscardedUsersSelected"
        size="sm"
        variant="outline-secondary"
        @click.prevent="undiscardUsers"
      >
        Undelete
      </b-button>

      <b-form-input
        v-model="searchKey"
        class="ml-auto mr-1 w-25"
        size="sm"
        @keydown.enter.native="filterUsers"
      />

      <b-form-select
        v-model="searchOption"
        class="mx-1 w-auto"
        :options="searchOptions"
        size="sm"
      />

      <b-button
        class="ml-1"
        size="sm"
        variant="outline-secondary"
        @click="filterUsers"
      >
        Search
      </b-button>
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
        <col class="actions-col">
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
        slot="actions"
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
            <b-card
              header="Licenses/Permits"
              header-class="h5"
            >
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

.actions-col {
  @include fixed-width(3rem);
}

/deep/ .table-discarded {
  color: $text-muted !important;
  font-style: italic !important;
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
