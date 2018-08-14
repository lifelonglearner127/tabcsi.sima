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
        email: '',
        pin: ''
      }
    }
  },

  computed: {
    pinRequested () {
      return !isEmpty(this.pageOptions.email)
    }
  },

  beforeMount () {
    if (this.pinRequested) {
      this.session.email = this.pageOptions.email
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
          Enter your Email Address to get Started
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
          <md-input
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
            <small>Not a member? <a :href="pageOptions.signUpPath">Register</a></small>
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
