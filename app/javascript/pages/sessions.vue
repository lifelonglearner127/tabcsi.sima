<script>
import { mdbBtn, mdbCard, mdbCardBody, mdbCardHeader, mdbCardTitle } from 'mdbvue'
import isEmpty from 'lodash/isEmpty'
import MdInput from '~/components/md-input'
import PageMixin from '~/mixins/page'
import RailsForm from '~/components/rails-form'

export default {
  name: 'Sessions',

  components: {
    mdbBtn,
    mdbCard,
    mdbCardBody,
    mdbCardHeader,
    mdbCardTitle,
    MdInput,
    RailsForm
  },

  mixins: [PageMixin],

  data () {
    return {
      session: {
        email: this.pageOptions.email || '',
        pin: ''
      }
    }
  },

  computed: {
    cardTitle () {
      if (this.pinRequested) {
        return 'Check your email for an "8 digit pin" and enter it here.'
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
  <b-row>
    <mdb-card>
      <mdb-card-header>
        <img
          alt="logo"
          class="card-img-top"
          src="~@/assets/images/logo.png"
        >
      </mdb-card-header>

      <mdb-card-body class="px-lg-5">
        <mdb-card-title
          class="text-center"
          tag="h5"
        >
          {{ cardTitle }}
        </mdb-card-title>

        <rails-form
          :accept-charset="acceptCharset"
          :action="action"
          :enforce-utf8="enforceUtf8"
          :hidden-method="hiddenMethod"
          :method="method"
          :token-name="tokenName"
          :token-value="tokenValue"
          class="text-center"
        >
          <template v-if="pinRequested">
            <md-input
              id="sessions_pin"
              input-class="text-center"
              maxlength="8"
              name="session[pin]"
            >
            </md-input>
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
          </template>
          <md-input
            v-else
            id="session_email"
            v-model="session.email"
            error-msg="You did not enter a valid e-mail"
            icon="fas-fa-envelope"
            label="E-mail"
            name="session[email]"
            type="email"
            validation="email"
          >
          </md-input>

          <mdb-btn
            class="my-4 waves-effect z-depth-0"
            color="primary"
            rounded
            size="md"
            type="submit"
          >
            Continue <fa-sprite use="fas-fa-arrow-right"></fa-sprite>
          </mdb-btn>

          <p>
            <small>{{ question.text }} <a :href="question.linkHref">{{ question.linkText }}</a></small>
          </p>
        </rails-form>
      </mdb-card-body>
    </mdb-card>
  </b-row>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

@include users_sessions_styles;

.card {
  margin: -225px 0 0 -175px;
  top: 50%;
  width: 350px;

  .card-body {
    padding-top: 10%;
  }
}

#sessions_pin {
  text-align: center;
}
</style>
