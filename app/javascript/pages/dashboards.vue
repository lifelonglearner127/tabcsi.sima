<script>
import { AdminDashboard, TabcDashboard, UserDashboard } from '~/components/dashboards'

import {
  mdbDropdown, mdbDropdownItem, mdbDropdownMenu, mdbDropdownToggle, mdbNavbar, mdbNavbarBrand, mdbNavbarNav,
  mdbNavbarToggler, mdbNavItem
} from 'mdbvue'

import PageMixin from '~/mixins/page'

export default {
  name: 'Dashboards',

  components: {
    AdminDashboard,
    mdbDropdown,
    mdbDropdownItem,
    mdbDropdownMenu,
    mdbDropdownToggle,
    mdbNavbar,
    mdbNavbarBrand,
    mdbNavbarNav,
    mdbNavbarToggler,
    mdbNavItem,
    TabcDashboard,
    UserDashboard
  },

  mixins: [PageMixin],

  computed: {
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
    <mdb-navbar
      class="bg-default justify-content-between"
      expand="large"
    >
      <mdb-navbar-brand href="/">{{ dashboardTitle }}</mdb-navbar-brand>
      <mdb-navbar-toggler>
        <mdb-navbar-nav>
          <mdb-dropdown
            class="nav-item"
            tag="li"
          >
            <mdb-dropdown-toggle
              slot="toggle"
              nav-link
              tag="a"
              waves-fixed
            >
              {{ user.fullName }}
            </mdb-dropdown-toggle>
            <mdb-dropdown-menu>
              <mdb-dropdown-item>
                <fa-sprite use="fas-fa-user"></fa-sprite> Update Profile
              </mdb-dropdown-item>
              <mdb-dropdown-item
                v-ujs-method="pageOptions.logOut.method"
                :href="pageOptions.logOut.path"
                rel="nofollow"
              >
                <fa-sprite use="fas-fa-sign-out-alt"></fa-sprite> Logout
              </mdb-dropdown-item>
            </mdb-dropdown-menu>
          </mdb-dropdown>
        </mdb-navbar-nav>
      </mdb-navbar-toggler>
    </mdb-navbar>

    <b-container fluid>
      <tabc-dashboard
        v-if="userIsTabcAdmin"
        :user="user"
      >
      </tabc-dashboard>
      <admin-dashboard
        v-else-if="userIsAdmin"
        :user="user"
      >
      </admin-dashboard>
      <user-dashboard
        v-else
        :user="user"
      >
      </user-dashboard>
    </b-container>
  </div>
</template>

<style lang="scss" scoped>
</style>
