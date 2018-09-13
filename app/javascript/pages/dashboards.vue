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
      variant="info"
    >
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-navbar-brand href="/">
        <img
          alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
          src="~@/assets/images/logo.png"
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
            <b-dropdown-item>
              <fa-sprite
                fixed-width
                use="fas-fa-user"
              >
              </fa-sprite>
              Update Profile
            </b-dropdown-item>
            <b-dropdown-item
              v-ujs-method="pageOptions.logOut.method"
              :href="pageOptions.logOut.path"
              rel="nofollow"
            >
              <fa-sprite
                fixed-width
                use="fas-fa-sign-out-alt"
              >
              </fa-sprite>
              Logout
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
.navbar-brand {
  img {
    padding-right: 1rem;
    width: 300px;
  }
}
</style>
