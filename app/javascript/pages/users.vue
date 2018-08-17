<script>
import { mdbBtn, mdbCard, mdbCardBody, mdbCardHeader, mdbCardTitle } from 'mdbvue'
import MdInput from '~/components/md-input'
import PageMixin from '~/mixins/page'
import RailsForm from '~/components/rails-form'

export default {
  name: 'Users',

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
      user: {
        companyName: '',
        email: '',
        fullName: '',
        jobTitle: '',
        licenseNumber: '',
        phone: ''
      }
    }
  }
}
</script>

<template>
  <b-row>
    <mdb-card>
      <mdb-card-header class="pb-4 pt-4 text-white">
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
          Create a New Account
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
            id="user_full_name"
            v-model="user.fullName"
            autocomplete="name"
            error-msg="Full name is required"
            icon="fas-fa-user"
            label="Full Name"
            length="min1"
            name="user[full_name]"
            validation="length"
          >
          </md-input>

          <md-input
            id="user_email"
            v-model="user.email"
            autocomplete="email"
            class="mt-0"
            error-msg="You did not enter a valid e-mail"
            icon="fas-fa-envelope"
            label="E-mail"
            name="user[email]"
            type="email"
            validation="email"
          >
          </md-input>

          <md-input
            id="user_phone"
            v-model="user.phone"
            class="mt-0"
            error-msg="Enter a valid phone number"
            icon="fas-fa-phone"
            label="Phone Number"
            length="14"
            name="user[phone]"
            validation="length"
          >
          </md-input>

          <md-input
            id="user_company_name"
            v-model="user.companyName"
            autocomplete="organization"
            class="mt-0"
            error-msg="Company name is required"
            icon="fas-fa-industry"
            label="Company Name"
            length="min1"
            name="user[company_name]"
            validation="length"
          >
          </md-input>

          <md-input
            id="user_job_title"
            v-model="user.jobTitle"
            autocomplete="organization-title"
            class="mt-0"
            error-msg="Job title is required"
            icon="fas-fa-user-tie"
            label="Job Title"
            length="min1"
            name="user[job_title]"
            validation="length"
          >
          </md-input>

          <md-input
            id="user_license_number"
            v-model="user.licenseNumber"
            class="mt-0"
            error-msg="Permit/License number is required"
            icon="fas-fa-id-card"
            label="Permit/License Number"
            length="min1"
            name="user[license_number]"
            validation="length"
          >
          </md-input>

          <small class="font-italic">
            <fa-sprite use="fas-fa-info-circle"></fa-sprite> Enter one of the permit/license numbers you are managing.
            For example: <strong>MB1234567</strong>. You will be assigned permits/licenses that are associated with this
            once you log in into the system.
          </small>

          <div>
            <mdb-btn
              class="my-4 waves-effect z-depth-0"
              color="primary"
              rounded
              size="md"
              type="submit"
            >
              Sign Up
            </mdb-btn>
          </div>
        </rails-form>
      </mdb-card-body>
    </mdb-card>
  </b-row>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/mixins';

@include users_sessions_styles;

.card {
  margin: 50px 0 50px -300px;
  top: 5%;
  width: 600px;
}
</style>
