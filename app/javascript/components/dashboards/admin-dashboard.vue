<script>
import filter from 'lodash/filter'
import http from '~/lib/http'
import isEmpty from 'lodash/isEmpty'
import LocationsTable from './locations-table'
import map from 'lodash/map'
import UsersTable from './users-table'

export default {
  name: 'AdminDashboard',

  components: {
    LocationsTable,
    UsersTable
  },

  props: {
    company: {
      type: Object,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },

  computed: {
    deleteDisabled () {
      return isEmpty(this.selectedUsers)
    },

    locations () {
      return this.user.locations || []
    },

    selectedUsers () {
      return filter(this.users, 'selected')
    },

    users () {
      return this.company.users || []
    }
  },

  methods: {
    deleteUsers () {
      this.$confirm(
        'Are you sure you want to delete the selected user(s)?',
        'Delete User(s)',
        { variant: 'error' }
      ).yes(() => {
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
    }
  }
}
</script>

<template>
  <b-card no-body>
    <b-tabs card>
      <b-tab active>
        <template slot="title">
          <fa-sprite
            fixed-width
            use="fas-fa-users"
          >
          </fa-sprite>
          Users
        </template>

        <b-button-toolbar
          class="mb-1 mt-4"
          key-nav
        >
          <b-dropdown
            class="mx-1"
            size="sm"
            variant="outline-secondary"
          >
            <template slot="button-content">
              <fa-sprite
                fixed-width
                use="fas-fa-user-plus"
              >
              </fa-sprite>
              Invite User
            </template>
            <b-dropdown-item
              class="px-3"
              href="/invite"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-plus"
              >
              </fa-sprite>
              Manual Add
            </b-dropdown-item>
            <b-dropdown-item class="px-3">
              <fa-sprite
                fixed-width
                use="fas-fa-file-upload"
              >
              </fa-sprite>
              Upload CSV (Coming Soon)
            </b-dropdown-item>
          </b-dropdown>
          <b-button
            class="mx-1"
            disabled
            size="sm"
            variant="outline-secondary"
          >
            <fa-sprite
              fixed-width
              use="fas-fa-user-edit"
            >
            </fa-sprite>
            Edit
          </b-button>
          <b-button
            :disabled="deleteDisabled"
            class="mx-1"
            size="sm"
            variant="outline-secondary"
            @click.prevent="deleteUsers"
          >
            <fa-sprite
              fixed-width
              use="fas-fa-user-times"
            >
            </fa-sprite>
            Delete
          </b-button>
        </b-button-toolbar>

        <users-table :items="users"></users-table>
      </b-tab>
      <b-tab>
        <template slot="title">
          <fa-sprite
            fixed-width
            use="fas-fa-map-marker-alt"
          >
          </fa-sprite>
          My Locations
        </template>

        <locations-table :items="locations"></locations-table>
      </b-tab>
    </b-tabs>
  </b-card>
</template>

<style lang="scss" scoped>
</style>
