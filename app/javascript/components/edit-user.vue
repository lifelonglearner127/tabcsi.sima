<script>
import { email, fullName, phone } from '~/validators'
import { AsYouType } from '~/lib/phone-number'
import { parseDigit } from '~/lib/utils'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'EditUser',

  mixins: [ValidationMixin('user')],

  props: {
    user: {
      type: Object,
      required: true
    }
  },

  data () {
    return {
      form: {
        fullName: {
          autoComplete: 'name',
          icon: 'fas-fa-user',
          label: 'Full Name',
          required: true
        },
        email: {
          autoComplete: 'email',
          icon: 'fas-fa-envelope',
          label: 'E-mail',
          maxLength: 192,
          required: true,
          type: 'email'
        },
        phone: {
          autoComplete: 'tel',
          component: 'vue-input',
          format: this.formatPhone,
          icon: 'fas-fa-phone',
          label: 'Phone Number',
          maxLength: 14,
          parse: this.parsePhone,
          type: 'tel'
        },
        jobTitle: {
          autoComplete: 'organization-title',
          icon: 'fas-fa-user-tie',
          label: 'Job Title',
          required: true
        }
      }
    }
  },

  validations () {
    return {
      user: {
        email: {
          required,
          email
        },
        fullName: {
          required,
          fullName
        },
        jobTitle: { required },
        phone: { phone }
      }
    }
  },

  methods: {
    formatPhone (value) {
      const asYouType = new AsYouType()
      const text = asYouType.input(value)
      const template = asYouType.template

      return {
        text, template
      }
    },

    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `user_${snakeCase(key)}`
    },

    inputName (key) {
      return `user[${snakeCase(key)}]`
    },

    parsePhone (ch) {
      return parseDigit(ch)
    }
  }
}
</script>

<template>
  <div>
    <input
      id="user_is_profile"
      name="user[is_profile]"
      type="hidden"
      value="true"
    >
    <template v-for="(options, key) in form">
      <b-form-group
        v-if="options.show == null ? true : options.show"
        :data-required="options.required"
        :id="inputGroupId(key)"
        :invalid-feedback="invalidFeedback(key)"
        :key="key"
        :label="options.label"
        :label-for="inputId(key)"
        :state="state(key)"
      >
        <b-input-group>
          <b-input-group-prepend is-text>
            <fa-sprite
              :use="options.icon"
              fixed-width
            >
            </fa-sprite>
          </b-input-group-prepend>
          <component
            v-model="$v.user[key].$model"
            :autocomplete="options.autoComplete"
            :data-path="key"
            :format="options.format"
            :id="inputId(key)"
            :is="options.component || 'b-form-input'"
            :maxlength="options.maxLength"
            :name="inputName(key)"
            :parse="options.parse"
            :placeholder="options.placeholder"
            :required="options.required"
            :type="options.type || 'text'"
            class="form-control"
            @blur.native="validate"
            @input.native="validate"
          >
          </component>
        </b-input-group>
      </b-form-group>
    </template>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.fa-phone {
  filter: fliph;
  transform: scaleX(-1);
}

.form-text {
  text-align: left;
}
</style>
