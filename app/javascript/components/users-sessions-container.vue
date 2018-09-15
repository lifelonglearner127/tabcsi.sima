<script>
import isEmpty from 'lodash/isEmpty'
import logo from '~/assets/images/logo-white.png'
import RailsForm from '~/components/rails-form'

export default {
  name: 'UsersSessionsContainer',

  components: { RailsForm },

  props: {
    acceptCharset: {
      type: String,
      default: null
    },
    action: {
      type: String,
      required: true
    },
    cols: {
      type: [String, Number],
      default: null
    },
    enforceUtf8: {
      type: Boolean,
      default: false
    },
    hiddenMethod: {
      type: String,
      default: null
    },
    lg: {
      type: [Boolean, String, Number],
      default: false
    },
    md: {
      type: [Boolean, String, Number],
      default: false
    },
    method: {
      type: String,
      required: true
    },
    serverErrors: {
      type: Object,
      default: null
    },
    sm: {
      type: [Boolean, String, Number],
      default: false
    },
    submitText: {
      type: String,
      default: null
    },
    text: {
      type: String,
      default: null
    },
    textClass: {
      type: [String, Array, Object],
      default: null
    },
    title: {
      type: String,
      required: true
    },
    tokenName: {
      type: String,
      required: true
    },
    tokenValue: {
      type: String,
      required: true
    },
    validationMethod: {
      type: Function,
      default: null
    },
    xl: {
      type: [Boolean, String, Number],
      default: false
    }
  },

  computed: {
    haveErrors () {
      return !isEmpty(this.serverErrors)
    },

    logoSrc () {
      return logo
    }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      align-v="center"
      class="h-100"
    >
      <b-col
        :cols="cols"
        :lg="lg"
        :md="md"
        :sm="sm"
        :xl="xl"
      >
        <b-card
          :title="title"
          header-class="py-4"
          title-tag="h5"
        >
          <b-card-img
            slot="header"
            :src="logoSrc"
            alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
            top
          >
          </b-card-img>
          <b-alert
            v-if="haveErrors"
            show
            variant="danger"
          >
            <span
              v-for="(error, key, index) in serverErrors"
              :key="index"
            >
              {{ error }}
            </span>
          </b-alert>
          <rails-form
            :accept-charset="acceptCharset"
            :action="action"
            :enforce-utf8="enforceUtf8"
            :hidden-method="hiddenMethod"
            :method="method"
            :validation-method="validationMethod"
            :token-name="tokenName"
            :token-value="tokenValue"
          >
            <slot />

            <b-button
              class="my-4"
              type="submit"
              variant="tabc-primary"
            >
              <slot name="submit">
                {{ submitText }}
              </slot>
            </b-button>

            <b-form-text
              v-if="text || $slots.text"
              :class="textClass"
            >
              <slot name="text">
                {{ text }}
              </slot>
            </b-form-text>
          </rails-form>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.card {
  box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
}

.card-header {
  background-color: $tabc-dark-blue;
  border-bottom-width: 0;
  color: $white;
  text-align: center;
}

.card-img-top {
  width: 300px;
}

.card-title {
  text-align: center;
}

form {
  color: $gray-600;
  text-align: center;

  /deep/ .form-group {
    text-align: left;
  }

  small {
    font-size: 75%;
  }
}
</style>
