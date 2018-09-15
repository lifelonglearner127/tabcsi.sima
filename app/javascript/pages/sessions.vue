<script>
import PageMixin from '~/mixins/page'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'Sessions',

  components: { UsersSessionsContainer },

  mixins: [PageMixin],

  data () {
    return {
      session: {
        email: this.pageOptions.email || '',
        pin: ''
      },
      serverErrors: this.pageOptions.errors || {}
    }
  },

  computed: {
    cardTitle () {
      if (this.pinRequested) {
        return `Check your email for an "${this.pageOptions.pinLength} digit` +
          ' pin" and enter it here.'
      }

      return 'Enter your email address to get started.'
    },

    question () {
      if (this.pinRequested) {
        return {
          linkHref: this.pageOptions.resendPinPath,
          linkText: 'Resend',
          text: 'Email not received?'
        }
      }

      return {
        linkHref: this.pageOptions.signUpPath,
        linkText: 'Register',
        text: 'Not a member?'
      }
    },

    pinRequested () {
      return Boolean(this.pageOptions.pinRequested)
    }
  },

  methods: {
    handlePinKeyUp (e) {
      // e.target.nextElementSibling.focus()
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
    :title="cardTitle"
    :token-name="tokenName"
    :token-value="tokenValue"
    cols="12"
    sm="4"
  >
    <b-form-group
      v-if="pinRequested"
      id="session_pin_group"
      label="PIN"
      label-for="session_pin"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            fixed-width
            use="fas-fa-key"
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="session_pin"
          v-model="session.pin"
          :maxlength="pageOptions.pinLength"
          name="session[pin]"
        >
        </b-form-input>
      </b-input-group>
      <!--<b-form-row>
        <b-col
          v-for="n in 8"
          :key="`pin${n}`"
        >
          <md-input
            :id="`session_pin${n}`"
            input-class="text-center"
            maxlength="1"
            name="session[pin][]"
            @keyup="handlePinKeyUp"
          >
          </md-input>
        </b-col>
      </b-form-row>-->
    </b-form-group>
    <b-form-group
      v-else
      id="session_email_group"
      label="E-mail"
      label-for="session_email"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            fixed-width
            use="fas-fa-envelope"
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          id="session_email"
          v-model="session.email"
          autocomplete="email"
          name="session[email]"
          type="email"
        >
        </b-form-input>
      </b-input-group>
    </b-form-group>

    <template slot="submit">
      Continue
      <fa-sprite
        fixed-width
        use="fas-fa-arrow-right"
      >
      </fa-sprite>
    </template>

    <template slot="text">
      {{ question.text }} <a :href="question.linkHref">{{ question.linkText }}</a>
    </template>
  </users-sessions-container>
</template>

<style lang="scss" scoped>
#session_pin {
  text-align: center;
}
</style>
