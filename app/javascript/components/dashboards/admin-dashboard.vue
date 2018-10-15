<script>
import filter from 'lodash/filter'
import http from '~/lib/http'
import isEmpty from 'lodash/isEmpty'
import LocationsTable from './locations-table'
import map from 'lodash/map'
import NewsTable from './news-table'
import UsersTable from './users-table'

export default {
  name: 'AdminDashboard',

  components: {
    LocationsTable,
    NewsTable,
    UsersTable
  },

  props: {
    adminCount: {
      type: Number,
      default: 0
    },
    company: {
      type: Object,
      default: null
    },
    locations: {
      type: Array,
      required: true
    },
    news: {
      type: Array,
      default: null
    },
    user: {
      type: Object,
      required: true
    },
    users: {
      type: Array,
      default: null
    }
  },

  computed: {
    isLocationsActive () {
      const oldTab = this.$cookies.get('admin-tab')

      return oldTab === 'locations'
    },

    isNewsActive () {
      const oldTab = this.$cookies.get('admin-tab')

      return oldTab === 'news'
    },

    isUsersActive () {
      const oldTab = this.$cookies.get('admin-tab')

      return isEmpty(oldTab) || oldTab === 'users'
    },

    locationsTabTitle () {
      return this.userIsTabc ? 'Locations' : 'My Locations'
    },

    multipleNewsSelected () {
      return this.selectedNews.length > 1
    },

    newsEditHref () {
      const firstItem = this.selectedNews[0]

      return firstItem ? `/news/${firstItem.id}/edit` : ''
    },

    noDiscardedUsersSelected () {
      return isEmpty(this.selectedDiscardedUsers)
    },

    noNewsSelected () {
      return isEmpty(this.selectedNews)
    },

    noUsersSelected () {
      return isEmpty(this.selectedUsers)
    },

    selectedDiscardedUsers () {
      return filter(this.users, (user) => user.selected && !isEmpty(user.discardedAt))
    },

    selectedNews () {
      return filter(this.news, 'selected')
    },

    selectedUsers () {
      return filter(this.users, (user) => user.selected && isEmpty(user.discardedAt))
    },

    showAdminAlert () {
      return !this.userIsTabc && this.adminCount <= 1
    },

    userIsTabc () {
      return this.user.role === 'tabc'
    }
  },

  methods: {
    deleteNews () {
      this
        .$confirm(
          'Are you sure you want to delete the selected news?',
          'Delete News',
          { variant: 'error' }
        )
        .yes(() => {
          Promise
            .all(
              map(
                this.selectedNews,
                (news) => http
                  .delete(`/news/${news.id}`)
                  .then(() => {
                    this.$message.success(`News "${news.subject}" deleted.`)
                  })
              )
            )
            .then(() => {
              window.location.reload(true)
            })
        })
    },

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

    saveTab (name) {
      this.$cookies.set('admin-tab', name)
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
    }
  }
}
</script>

<template>
  <b-container>
    <b-row v-if="showAdminAlert">
      <b-col>
        <b-alert
          show
          variant="info"
        >
          <h4 class="alert-heading">
            <fa-sprite
              fixed-width
              use="fas-fa-info-circle"
            />
            Add an Account Admin
          </h4>
          <p>
            For the benefit of your organization, we highly recommend adding more than one admin so you always have a
            safe backup for accessing the business account.
          </p>
        </b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col cols="12">
        <b-card no-body>
          <b-tabs card>
            <b-tab
              :active="isUsersActive"
              @click="saveTab('users')"
            >
              <template slot="title">
                <fa-sprite
                  fixed-width
                  use="fas-fa-users"
                />
                Users
              </template>

              <b-button-toolbar
                class="mb-3 ml-3"
                key-nav
              >
                <b-dropdown
                  class="mx-1"
                  :disabled="userIsTabc"
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
                  class="mx-1"
                  :disabled="noDiscardedUsersSelected"
                  size="sm"
                  variant="outline-secondary"
                  @click.prevent="undiscardUsers"
                >
                  Undelete
                </b-button>
              </b-button-toolbar>

              <users-table
                :current-user="user"
                :items="users"
              />
            </b-tab>

            <b-tab
              :active="isLocationsActive"
              @click="saveTab('locations')"
            >
              <template slot="title">
                <fa-sprite
                  fixed-width
                  use="fas-fa-map-marker-alt"
                />
                {{ locationsTabTitle }}
              </template>

              <locations-table :items="locations" />
            </b-tab>

            <b-tab
              v-if="userIsTabc"
              :active="isNewsActive"
              @click="saveTab('news')"
            >
              <template slot="title">
                <fa-sprite
                  fixed-width
                  use="fas-fa-newspaper"
                />
                News
              </template>

              <b-button-toolbar
                class="mb-3 ml-3"
                key-nav
              >
                <b-button
                  class="mx-1"
                  href="/news/new"
                  size="sm"
                  variant="outline-secondary"
                >
                  Add
                </b-button>
                <b-button
                  class="mx-1"
                  :disabled="noNewsSelected || multipleNewsSelected"
                  :href="newsEditHref"
                  size="sm"
                  variant="outline-secondary"
                >
                  Edit
                </b-button>
                <b-button
                  class="mx-1"
                  :disabled="noNewsSelected"
                  size="sm"
                  variant="outline-secondary"
                  @click.prevent="deleteNews"
                >
                  Delete
                </b-button>
              </b-button-toolbar>

              <news-table :items="news" />
            </b-tab>
          </b-tabs>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
.card-body {
  padding: 1.25rem 0 0;
}

/deep/ .table {
  margin-bottom: 0;
}
</style>
