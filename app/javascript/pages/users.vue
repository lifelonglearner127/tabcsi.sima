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

    ownerName () {
      return this.pageOptions.ownerName
    },

    user () {
      return this.pageOptions.user || {}
    },

    isInvite () {
      return this.pageName === 'invite'
    },

    isProfile () {
      return this.pageName === 'profile'
    },

    isSignUp () {
      return this.pageName === 'sign-up'
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
    <new-user
      v-if="isSignUp || isInvite"
      ref="newUser"
      :is-sign-up="isSignUp"
      :owner-name="ownerName"
    >
    </new-user>
    <edit-user
      v-if="isProfile"
      ref="editUser"
      :user="user"
    >
    </edit-user>
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
