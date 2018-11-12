<script>
import isEmpty from 'lodash/isEmpty'
import LocationsTable from './locations-table'
import NewsTable from './news-table'
import ReportsTable from './reports-table'
import UsersTable from './users-table'

const TABS = {
  default: 'users',
  list: ['users', 'locations', 'news', 'reports']
}

export default {
  name: 'AdminDashboard',

  components: {
    LocationsTable,
    NewsTable,
    ReportsTable,
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
    fiscalYears: {
      type: Array,
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
    reports: {
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
    locationsTabTitle () {
      return this.userIsTabc ? 'Locations' : 'My Locations'
    },

    showAdminAlert () {
      return !this.userIsTabc && this.adminCount <= 1
    },

    userIsTabc () {
      return this.user.role === 'tabc'
    }
  },

  methods: {
    isTabActive (tabName) {
      let oldTab

      oldTab = this.$cookies.get('admin-tab')
      if (isEmpty(oldTab)) {
        oldTab = TABS.default
      }

      return oldTab === tabName
    },

    saveTab (name) {
      this.$cookies.set('admin-tab', name)
    }
  }
}
</script>

<template>
  <b-container fluid>
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
          <b-tabs
            card
            nav-class="admin-tabs"
          >
            <b-tab
              :active="isTabActive('users')"
              @click="saveTab('users')"
            >
              <template slot="title">
                <fa-sprite
                  fixed-width
                  use="fas-fa-users"
                />
                Users
              </template>

              <users-table
                :current-user="user"
                :items="users"
              />
            </b-tab>

            <b-tab
              :active="isTabActive('locations')"
              @click="saveTab('locations')"
            >
              <template slot="title">
                <fa-sprite
                  fixed-width
                  use="fas-fa-map-marker-alt"
                />
                {{ locationsTabTitle }}
              </template>

              <locations-table
                :is-tabc-admin="userIsTabc"
                :items="locations"
              />
            </b-tab>

            <template v-if="userIsTabc">
              <b-tab
                :active="isTabActive('news')"
                @click="saveTab('news')"
              >
                <template slot="title">
                  <fa-sprite
                    fixed-width
                    use="fas-fa-newspaper"
                  />
                  News
                </template>

                <news-table :items="news" />
              </b-tab>

              <b-tab
                :active="isTabActive('reports')"
                @click="saveTab('reports')"
              >
                <template slot="title">
                  <fa-sprite
                    fixed-width
                    use="fas-fa-file-invoice"
                  />
                  Reports
                </template>

                <reports-table
                  :fiscal-years="fiscalYears"
                  :items="reports"
                />
              </b-tab>
            </template>
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

@media (max-width: 414px) {
  /deep/ .admin-tabs {
    font-size: 80%;
    font-weight: 400;
  }
}
</style>
