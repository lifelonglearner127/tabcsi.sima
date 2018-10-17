<script>
import { AdminDashboard, UserDashboard } from '~/components/dashboards'
import { subscribeToChannels, unsubscribeFromChannels } from '~/channels'
import includes from 'lodash/includes'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import PageMixin from '~/mixins/page'

const DASHBOARD_TITLES = {
  admin: 'Admin',
  tabc: 'TABC',
  user: 'User'
}

export default {
  name: 'Dashboards',

  components: {
    AdminDashboard,
    UserDashboard
  },

  mixins: [PageMixin],

  computed: {
    adminCount () {
      return this.pageOptions.adminCount || 0
    },

    company () {
      return this.pageOptions.company || {}
    },

    dashboardTitle () {
      return `${DASHBOARD_TITLES[this.user.role]} Dashboard`
    },

    locations () {
      return this.tabc.locations || this.user.locations || []
    },

    news () {
      return this.tabc.news || []
    },

    tabc () {
      return this.pageOptions.tabc || {}
    },

    tabcContactUrl () {
      return this.pageOptions.tabcContactUrl || 'about:blank'
    },

    user () {
      return this.pageOptions.user || {}
    },

    userIsAdmin () {
      return includes(['admin', 'tabc'], this.user.role)
    },

    users () {
      return map(this.tabc.users || this.company.users || [], (user) => {
        if (!isEmpty(user.discardedAt)) {
          user._rowVariant = 'discarded'
        } else if (user._rowVariant) {
          delete user._rowVariant
        }

        return user
      })
    }
  },

  mounted () {
    subscribeToChannels()
  },

  beforeDestroy () {
    unsubscribeFromChannels()
  }
}
</script>

<template>
  <div>
    <b-navbar
      class="mb-3"
      toggleable="md"
      type="dark"
    >
      <b-navbar-toggle target="nav_collapse" />
      <b-navbar-brand href="/">
        <img
          alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
          src="@/assets/images/logo-white.png"
        >
        {{ dashboardTitle }}
      </b-navbar-brand>
      <b-collapse
        id="nav_collapse"
        is-nav
      >
        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown
            right
            :text="user.fullName"
          >
            <b-dropdown-item :href="`/users/${user.id}/edit`">
              <fa-sprite
                fixed-width
                use="fas-fa-user"
              />
              Update Profile
            </b-dropdown-item>
            <b-dropdown-item
              :href="tabcContactUrl"
              target="_blank"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-phone"
              />
              Contact TABC
            </b-dropdown-item>
            <b-dropdown-divider />
            <b-dropdown-item
              v-ujs-confirm="'Are you sure you want to log-out?'"
              v-ujs-method="'delete'"
              href="/log_out"
              rel="nofollow"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-sign-out-alt"
              />
              Log Out
            </b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <div class="dashboard-container">
      <admin-dashboard
        v-if="userIsAdmin"
        :admin-count="adminCount"
        :company="company"
        :locations="locations"
        :news="news"
        :user="user"
        :users="users"
      />
      <user-dashboard
        v-else
        :user="user"
      />
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.navbar {
  background-color: $tabc-dark-blue;
}

.navbar-brand {
  img {
    padding-right: 1rem;
    width: 300px;
  }
}

.dashboard-container {
  margin: 0 6.25rem 2rem;
}
</style>
