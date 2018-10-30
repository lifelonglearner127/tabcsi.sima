<script>
import { email, exactLength } from '~/validators'
import { getBoolean } from '~/lib/utils'
import PageMixin from '~/mixins/page'
import { required } from 'vuelidate/lib/validators'
import UsersSessionsContainer from '~/components/users-sessions-container'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'Sessions',

  components: { UsersSessionsContainer },

  mixins: [
    PageMixin,
    ValidationMixin('session')
  ],

  data () {
    return {
      session: {
        email: this.pageOptions.email || '',
        pin: ''
      }
    }
  },

  validations () {
    const schema = { session: {} }

    if (this.pinRequested) {
      schema.session.pin = {
        required,
        exactLength: exactLength(this.pinLength)
      }
    } else {
      schema.session.email = {
        required,
        email
      }
    }

    return schema
  },

  computed: {
    cardTitle () {
      if (this.pinRequested) {
        return `Check your email for an "${this.pinLength} digit pin" and enter it here.`
      }

      return 'Enter your email address to get started.'
    },

    pinLength () {
      return this.pageOptions.pinLength || 1
    },

    pinRequested () {
      return getBoolean(this.pageOptions, 'pinRequested')
    },

    question () {
      if (this.pinRequested) {
        return {
          linkHref: '/resend_pin',
          linkMethod: 'post',
          linkText: 'Resend',
          text: 'Email not received?'
        }
      }

      return {
        linkHref: '/sign_up',
        linkText: 'Register',
        text: 'Not a member?'
      }
    }
  }
}
</script>

<template>
  <users-sessions-container
    :accept-charset="acceptCharset"
    :action="action"
    back-href="/log_out"
    back-method="delete"
    cols="12"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :server-errors="serverErrors"
    :show-back-button="pinRequested"
    sm="4"
    :title="cardTitle"
    :token-name="tokenName"
    :token-value="tokenValue"
  >
    <template v-if="pinRequested">
      <h6>{{ session.email }}</h6>
      <b-form-group
        id="session_pin_group"
        data-required
        :invalid-feedback="invalidFeedback('pin')"
        label="PIN"
        label-for="session_pin"
        :state="state('pin')"
      >
        <b-input-group>
          <b-input-group-prepend is-text>
            <fa-sprite
              fixed-width
              use="fas-fa-key"
            />
          </b-input-group-prepend>
          <b-form-input
            id="session_pin"
            v-model="session.pin"
            autocomplete="off"
            data-path="pin"
            :maxlength="pageOptions.pinLength"
            name="session[pin]"
            placeholder="12345678"
            required
            @blur.native="validate"
            @input.native="validate"
          />
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
    </template>
    <b-form-group
      v-else
      id="session_email_group"
      data-required
      description="You'll need access to this email address to verify your account."
      :invalid-feedback="invalidFeedback('email')"
      label="E-mail"
      label-for="session_email"
      :state="state('email')"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            fixed-width
            use="fas-fa-envelope"
          />
        </b-input-group-prepend>
        <b-form-input
          id="session_email"
          v-model="session.email"
          autocomplete="off"
          data-path="email"
          maxlength="192"
          name="session[email]"
          placeholder="jsmith@example.com"
          required
          @blur.native="validate"
          @input.native="validate"
        />
      </b-input-group>
    </b-form-group>

    <template slot="submit">
      Continue
      <fa-sprite
        fixed-width
        use="fas-fa-arrow-right"
      />
    </template>

    <template slot="text">
      {{ question.text }}
      <a
        v-ujs-method="question.linkMethod"
        :href="question.linkHref"
      >
        {{ question.linkText }}
      </a>
    </template>
  </users-sessions-container>
</template>

<style lang="scss" scoped>
@media only screen and (min-height: 512px) {
  /deep/ .container-row {
    align-items: center;
  }
}

#session_pin {
  text-align: center;
}
</style>
