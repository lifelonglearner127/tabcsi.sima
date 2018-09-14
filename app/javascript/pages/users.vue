<script>
import PageMixin from '~/mixins/page'
import snakeCase from 'lodash/snakeCase'
import UsersSessionsContainer from '~/components/users-sessions-container'
import { helpers } from 'vuelidate/lib/validators'
import { required, minLength, maxLength, email } from 'vuelidate/lib/validators'

const alpha = helpers.regex('alpha', /^[a-zA-Z\s]+$/)
const USPhone = (value) => {
  if (typeof value === 'undefined' || value === null || value === '') {
    return true
  }

  return /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/.test(value)
}
  

export default {
  name: 'Users',

  components: { UsersSessionsContainer },

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
  },

  validations: {
    user: {
      fullName: {
        required,
        alpha
      },
      email: {
        required, 
        email
      },
      phone: {
        required,
        USPhone
      },
      companyName: {
        required
      },
      jobTitle: {
        required
      },
      licenseNumber: {
        required
      }
    }
  },

  methods: {
    validateBeforeSubmit() {
      this.$v.$touch()
      if (this.$v.$invalid) {
        
      } else {
        return
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
    :validation-method="validateBeforeSubmit"
    :token-name="tokenName"
    :token-value="tokenValue"
    cols="12"
    sm="6"
    submit-text="Sign Up"
    text-class="font-italic"
    title="Create a New Account"
  >
    <!-- Full Name -->
    <b-form-group
      id="user_full_name_group"
      label="Full Name"
      label-for="user_full_name"
      
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.fullName.$model"
          autocomplete="name"
          id="user_full_name"
          name="user[full_name]"
          type="text"
          placeholder="xyz abc"
          :class="{'is-invalid': $v.user.fullName.$error}"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback class="d-block" v-if="$v.user.fullName.$error && !$v.user.fullName.required" >
        Full Name is required.
      </b-form-feedback>
      <b-form-feedback class="d-block" v-if="$v.user.fullName.$error && !$v.user.fullName.alpha" >
        Please enter only characters.
      </b-form-feedback>
    </b-form-group>
    

    <!-- Email -->
    <b-form-group
      id="user_email_group"
      label="E-mail"
      label-for="user_email"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-envelope"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.email.$model"
          autocomplete="email"
          id="user_email"
          name="user[email]"
          type="email"
          placeholder="tabc@neuone.com"
          :class="{'is-invalid': $v.user.email.$error}"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback class="d-block" v-if="$v.user.email.$error && !$v.user.email.required" >
        Email is required.
      </b-form-feedback>
      <b-form-feedback class="d-block" v-if="$v.user.email.$error && !$v.user.email.email" >
        Please enter a valid email address.
      </b-form-feedback>
    </b-form-group>

    <!-- Phone Number -->
    <b-form-group
      id="user_phone_group"
      label="Phone Number"
      label-for="user_phone"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-phone"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.phone.$model"
          autocomplete="tel"
          id="user_phone"
          name="user[phone]"
          type="text"
          placeholder="(512) 099-2736"
          :class="{'is-invalid': $v.user.phone.$error}"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback class="d-block" v-if="$v.user.phone.$error && !$v.user.phone.required" >
        Phone Number is required.
      </b-form-feedback>
      <b-form-feedback class="d-block" v-if="$v.user.phone.$error && !$v.user.phone.USPhone" >
        Please enter a valid format phone number.
      </b-form-feedback>
    </b-form-group>

    <!-- Company Name -->
    <b-form-group
      id="user_company_name_group"
      label="Company Name"
      label-for="user_company_name"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-industry"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.companyName.$model"
          autocomplete="organization"
          id="user_company_name"
          name="user[company_name]"
          type="text"
          placeholder="Neuone"
          :class="{'is-invalid': $v.user.companyName.$error}"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback class="d-block" v-if="$v.user.companyName.$error" >
        Company Name is required.
      </b-form-feedback>
    </b-form-group>

    <!-- Job Title -->
    <b-form-group
      id="user_job_title_group"
      label="Job Title"
      label-for="user_job_title"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user-tie"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.jobTitle.$model"
          autocomplete="organization-title"
          id="user_job_title"
          name="user[job_title]"
          type="text"
          placeholder="Owner"
          :class="{'is-invalid': $v.user.jobTitle.$error}"
        >
        </b-form-input>
      </b-input-group>
       <b-form-feedback class="d-block" v-if="$v.user.jobTitle.$error" >
        Job Title is required.
      </b-form-feedback>
    </b-form-group>

    <!-- License/Permit Number -->
    <b-form-group
      id="user_license_number_group"
      label="License/Permit Number"
      label-for="user_license_number"
    >
      <b-input-group>
        <b-input-group-prepend is-text>
          <fa-sprite
            use="fas-fa-user-tie"
            fixed-width
          >
          </fa-sprite>
        </b-input-group-prepend>
        <b-form-input
          v-model="$v.user.licenseNumber.$model"
          autocomplete="off"
          id="user_license_number"
          name="user[license_number]"
          type="text"
          placeholder="AB123456"
          :class="{'is-invalid': $v.user.licenseNumber.$error}"
        >
        </b-form-input>
      </b-input-group>
      <b-form-feedback class="d-block" v-if="$v.user.licenseNumber.$error" >
        License/Permit Number is required.
      </b-form-feedback>
    </b-form-group>

    <b-form-text class="font-italic">
      <fa-sprite
        fixed-width
        use="fas-fa-info-circle"
      >
      </fa-sprite>
      Enter one of the license/permit numbers you are managing. For
      example: <strong>MB1234567</strong>. You will be assigned licenses/permits that are associated with this once you
      log in into the system.
    </b-form-text>
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
