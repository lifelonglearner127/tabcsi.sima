<script>
import NewUser from '~/components/new-user'
import PageMixin from '~/mixins/page'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'Users',

  components: {
    NewUser,
    UsersSessionsContainer
  },

  mixins: [PageMixin],

  computed: {
    cardTitle () {
      return this.isInvite ? 'Invite a New User' : 'Create a New Account'
    },

    companyName () {
      return this.pageOptions.companyName
    },

    isInvite () {
      return 'isInvite' in this.pageOptions && Boolean(this.pageOptions.isInvite)
    },

    submitText () {
      return this.isInvite ? 'Invite' : 'Sign Up'
    }
  },

  methods: {
    validate (e) {
      if (this.$refs.newUser.validateBeforeSubmit()) {
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
    <template v-if="isInvite">
      <input
        id="user_is_invite"
        name="user[is_invite]"
        type="hidden"
        value="true"
      >
      <input
        id="user_company_name"
        :value="companyName"
        name="user[company_name]"
        type="hidden"
      >
    </template>
    <new-user
      ref="newUser"
      :is-sign-up="!isInvite"
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
