<script>
import { addSearchedItem, filterItems, formatDateTime } from '~/lib/utils'
import chunk from 'lodash/chunk'
import compact from 'lodash/compact'
import DashboardTable from './dashboard-table'
import filter from 'lodash/filter'
import http from '~/lib/http'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import sortBy from 'lodash/sortBy'
import startCase from 'lodash/startCase'

const DISPLAY_BOXES_PER_ROW = 6
const RELOAD_DELAY = 1000

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
      obj.searchOptions.unshift(
        {
          text: 'Company Name',
          value: 'companyName'
        },
        {
          text: 'Owner Name',
          value: 'ownerName'
        }
      )
    }

    return obj
  },

  computed: {
    currentUserIsTabc () {
      return this.isTabc(this.currentUser)
    },

    fields () {
      const value = [
        {
          key: 'fullName',
          sortable: true
        },
        {
          key: 'email',
          sortable: true
        },
        {
          key: 'jobTitle',
          sortable: true
        },
        {
          key: 'phone',
          sortable: true
        },
        {
          key: 'role',
          label: 'Type',
          sortable: true,

          formatter (columnValue) {
            return startCase(columnValue)
          }
        },
        {
          key: 'pinLastRequestedAt',
          label: 'Logged In',
          sortable: true,

          formatter (columnValue) {
            return isEmpty(columnValue) ? 'Never logged in.' : formatDateTime(columnValue)
          }
        },
        {
          key: 'tailActions',
          label: '',
          tdClass: 'text-center',
          sortable: false
        }
      ]

      if (this.currentUserIsTabc) {
        value.unshift(
          {
            key: 'company.name',
            label: 'Company Name',
            sortable: true
          },
          {
            key: 'company.ownerName',
            label: 'Owner Name',
            sortable: true
          }
        )
      }

      value.unshift({
        key: 'headActions',
        label: '',
        tdClass: 'first-column',
        sortable: false
      })

      return value
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
    const searchParams = this.$cookies.get('users-search-params')

    if (searchParams) {
      this.searchKey = searchParams.searchKey
      this.searchOption = searchParams.searchOption

      this.filterUsers()
    } else {
      this.searchOption = 'fullName'
    }
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
              setTimeout(() => window.location.reload(true), RELOAD_DELAY)
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
      this.$cookies.set('users-search-params', {
        searchKey: this.searchKey,
        searchOption: this.searchOption
      })

      this.filteredItems = filterItems(this.items, this.searchKey, (filteredItems, item, value) => {
        switch (this.searchOption) {
          case 'companyName':
            addSearchedItem(filteredItems, item, value, ['company.name', 'company.ownerName'])
            break

          case 'ownerName':
            addSearchedItem(filteredItems, item, value, 'company.ownerName')
            break

          case 'fullName':
            addSearchedItem(filteredItems, item, value, 'fullName')
            break

          case 'email':
            addSearchedItem(filteredItems, item, value, 'email')
            break
          // no default
        }
      })
    },

    isDiscarded (user) {
      return !isEmpty(user.discardedAt)
    },

    isTabc (user) {
      return user.role === 'tabc'
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
              setTimeout(() => window.location.reload(true), RELOAD_DELAY)
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
    }
  }
}
</script>

<template>
  <div>
    <b-button-toolbar class="mb-3 mx-3">
      <div class="action-buttons">
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
            href="/import/upload_users_csv"
          >
            <fa-sprite
              fixed-width
              use="fas-fa-file-upload"
            />
            Upload CSV
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
      </div>

      <div class="search-fields">
        <b-form-input
          v-model="searchKey"
          class="mr-1"
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
      </div>
    </b-button-toolbar>

    <dashboard-table
      :fields="fields"
      :items="filteredItems"
      sort-by="fullName"
      table-class="users-table"
    >
      <template slot="table-colgroup">
        <col class="head-actions-col">
        <template v-if="currentUserIsTabc">
          <col class="company-name-col">
          <col class="company-owner-name-col">
        </template>
        <col class="full-name-col">
        <col class="email-col">
        <col class="job-title-col">
        <col class="phone-col">
        <col class="role-col">
        <col class="pin-last-requested-at-col">
        <col class="tail-actions-col">
      </template>

      <template
        slot="headActions"
        slot-scope="row"
      >
        <template v-if="!isTabc(row.item)">
          <a
            href="#"
            @click.prevent.stop="row.toggleDetails"
          >
            <fa-sprite
              fixed-width
              :use="row.detailsShowing ? 'far-fa-minus-square' : 'far-fa-plus-square'"
            />
          </a>
        </template>
        <b-form-checkbox
          :id="`user_${row.index}_selected`"
          v-model="row.item.selected"
          :disabled="row.item.id === currentUser.id"
          @click.native.stop
        />
      </template>

      <a
        slot="tailActions"
        slot-scope="row"
        href="#"
        title="Edit"
        @click.prevent.stop="editUser(row.item)"
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

.head-actions-col {
  @include fixed-width(4.3125rem);
}

.company-name-col {
  width: auto;
}

.company-owner-name-col {
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

.role-col {
  @include fixed-width(5rem);
}

.pin-last-requested-at-col {
  @include fixed-width(12.5rem);
}

.tail-actions-col {
  @include fixed-width(3rem);
}

.btn-toolbar .search-fields {
  display: flex;
  margin-left: auto;

  @media (max-width: 737px) {
    margin-top: 0.25rem;
    margin-left: 0 !important;
  }
}

/deep/ .table-discarded {
  color: $text-muted !important;
  font-style: italic !important;
}

/deep/ .first-column {
  white-space: nowrap;

  > .custom-checkbox {
    margin-right: 0;
    min-height: auto;
    padding-left: 0;
    vertical-align: -0.25rem;

    &:first-child {
      margin-left: 1.5625rem;
    }

    .custom-control-label {
      min-height: 1.25rem;
      min-width: 1.25rem;

      &::before,
      &::after {
        left: 0.125rem;
        top: 0.125rem;
      }
    }
  }
}

.license-box {
  border: 1px solid gray;
  margin: 0 5px 5px 0;
  padding: 0.5rem
}

/deep/ .users-table table {
  min-width: 1250px;
}
</style>
