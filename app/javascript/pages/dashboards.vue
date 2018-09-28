<script>
import { AdminDashboard, TabcDashboard, UserDashboard } from '~/components/dashboards'
import PageMixin from '~/mixins/page'

export default {
  name: 'Dashboards',

  components: {
    AdminDashboard,
    TabcDashboard,
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
      if (this.userIsTabcAdmin) {
        return 'TABC Dashboard'
      }

      if (this.userIsAdmin) {
        return 'Admin Dashboard'
      }

      return 'User Dashboard'
    },

    user () {
      return this.pageOptions.user || {}
    },

    userIsAdmin () {
      return this.user.role === 'admin'
    },

    userIsTabcAdmin () {
      return this.user.role === 'tabc'
    }
  }
}
</script>

<template>
  <div>
    <b-navbar
      toggleable="md"
      type="dark"
    >
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-navbar-brand href="/">
        <img
          alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
          src="~@/assets/images/logo-white.png"
        >
        {{ dashboardTitle }}
      </b-navbar-brand>
      <b-collapse
        id="nav_collapse"
        is-nav
      >
        <b-navbar-nav class="ml-auto">
          <b-nav-item-dropdown
            :text="user.fullName"
            right
          >
            <b-dropdown-item href="/profile">
              <fa-sprite
                fixed-width
                use="fas-fa-user"
              >
              </fa-sprite>
              Update Profile
            </b-dropdown-item>
            <b-dropdown-item
              href="https://www.tabc.texas.gov/mobile/"
              target="_blank"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-phone"
              >
              </fa-sprite>
              Contact TABC
            </b-dropdown-item>
            <b-dropdown-divider></b-dropdown-divider>
            <b-dropdown-item
              v-ujs-confirm="'Are you sure you want to log-out?'"
              v-ujs-method="'delete'"
              href="/log_out"
              rel="nofollow"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-sign-out-alt"
              >
              </fa-sprite>
              Log Out
            </b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>

    <b-container
      class="my-5"
      fluid
    >
      <b-row>
        <b-col>
          <tabc-dashboard
            v-if="userIsTabcAdmin"
            :user="user"
          >
          </tabc-dashboard>
          <admin-dashboard
            v-else-if="userIsAdmin"
            :admin-count="adminCount"
            :company="company"
            :user="user"
          >
          </admin-dashboard>
          <user-dashboard
            v-else
            :user="user"
          >
          </user-dashboard>
        </b-col>
      </b-row>
    </b-container>
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
</style>
