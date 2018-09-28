<script>
import EditUser from '~/components/edit-user'
import NewUser from '~/components/new-user'
import PageMixin from '~/mixins/page'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'Users',

  components: {
    EditUser,
    NewUser,
    UsersSessionsContainer
  },

  mixins: [PageMixin],

  computed: {
    cardTitle () {
      switch (this.pageName) {
        case 'invite':
          return 'Invite a New User'

        case 'profile':
          return 'Update Profile'

        default:
          return 'Create a New Account'
      }
    },

    isInvite () {
      return this.pageName === 'invite'
    },

    isProfile () {
      return this.pageName === 'profile'
    },

    locations () {
      return this.pageOptions.locations || []
    },

    ownerName () {
      return this.pageOptions.ownerName
    },

    submitText () {
      switch (this.pageName) {
        case 'invite':
          return 'Invite'

        case 'profile':
          return 'Update Profile'

        default:
          return 'Sign Up'
      }
    },

    user () {
      return this.pageOptions.user || {}
    }
  },

  methods: {
    validate (e) {
      if (
        (this.$refs.newUser && this.$refs.newUser.validateBeforeSubmit()) ||
        (this.$refs.editUser && this.$refs.editUser.validateBeforeSubmit())
      ) {
        e.target.submit()
      }
    }
  }
}
</script>

<template>
  <users-sessions-container
    :accept-charset="acceptCharset"
    :action="action"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :server-errors="serverErrors"
    :submit-text="submitText"
    :title="cardTitle"
    :token-name="tokenName"
    :token-value="tokenValue"
    :validation-method="validate"
    back-href="/"
    cols="12"
    show-back-button
    show-top-back-button
    sm="6"
    text-class="font-italic"
  >
    <edit-user
      v-if="isProfile"
      ref="editUser"
      :user="user"
    >
    </edit-user>
    <new-user
      v-else
      ref="newUser"
      :is-invite="isInvite"
      :locations="locations"
      :owner-name="ownerName"
    >
    </new-user>
  </users-sessions-container>
</template>

<style lang="scss" scoped>
.fa-phone {
  filter: fliph;
  transform: scaleX(-1);
}

.form-text {
  text-align: left;
}
</style>
