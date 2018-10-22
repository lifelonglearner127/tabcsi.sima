<script>
import isEmpty from 'lodash/isEmpty'
import RailsForm from '~/components/rails-form'
import TabcCard from '~/components/tabc-card'

export default {
  name: 'UsersSessionsContainer',

  components: {
    RailsForm,
    TabcCard
  },

  props: {
    acceptCharset: {
      type: String,
      default: null
    },
    action: {
      type: String,
      required: true
    },
    backHref: {
      type: String,
      default: null
    },
    backMethod: {
      type: String,
      default: null
    },
    cols: {
      type: [String, Number],
      default: null
    },
    enforceUtf8: Boolean,
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
    showBackButton: Boolean,
    showTopBackButton: Boolean,
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

    backButtonVisible () {
      return this.showBackButton
    },

    topBackButtonVisible () {
      return this.backButtonVisible && this.showTopBackButton
    }
  }
}
</script>

<template>
  <tabc-card
    :cols="cols"
    :lg="lg"
    :md="md"
    :sm="sm"
    :title="title"
    :xl="xl"
  >
    <b-alert
      v-if="haveErrors"
      show
      variant="danger"
    >
      <ul>
        <li
          v-for="(error, key, index) in serverErrors"
          :key="index"
        >
          {{ error }}
        </li>
      </ul>
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
      <b-button
        v-if="topBackButtonVisible"
        v-ujs-method="backMethod"
        class="mb-4"
        :href="backHref"
        variant="secondary"
      >
        <slot name="back">
          <fa-sprite
            fixed-width
            use="fas-fa-arrow-left"
          />
          Back
        </slot>
      </b-button>

      <slot />

      <b-button
        v-if="backButtonVisible"
        v-ujs-method="backMethod"
        class="my-4"
        :href="backHref"
        variant="secondary"
      >
        <slot name="back">
          <fa-sprite
            fixed-width
            use="fas-fa-arrow-left"
          />
          Back
        </slot>
      </b-button>

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
  </tabc-card>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.alert {
  ul {
    margin-bottom: 0;
  }
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
