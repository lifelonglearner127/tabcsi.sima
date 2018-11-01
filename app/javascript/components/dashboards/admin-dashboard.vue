<script>
import CsvChannel from '~/channels/csv'
import isEmpty from 'lodash/isEmpty'
import LocationsTable from './locations-table'
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

    showAdminAlert () {
      return !this.userIsTabc && this.adminCount <= 1
    },

    userIsTabc () {
      return this.user.role === 'tabc'
    }
  },

  mounted () {
    this.channelSub = CsvChannel()
  },

  beforeDestroy () {
    this.channelSub.unsubscribe()
    this.channelSub = null
  },

  methods: {
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

              <locations-table
                :is-tabc-admin="userIsTabc"
                :items="locations"
              />
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
