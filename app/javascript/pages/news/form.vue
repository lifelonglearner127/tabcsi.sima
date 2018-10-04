<script>
import { ensureDebounceFunc } from '~/lib/utils'
import get from 'lodash/get'
import { getMessage } from '~/validators'
import isEmpty from 'lodash/isEmpty'
import logo from '~/assets/images/logo-white.png'
import RailsForm from '~/components/rails-form'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'

const DEBOUNCE_DELAY = 250 // milliseconds

export default {
  name: 'NewsForm',

  components: { RailsForm },

  props: {
    news: {
      type: Object,
      required: true
    },
    newsTypes: {
      type: Array,
      required: true
    },
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
    showBackButton: {
      type: Boolean,
      default: false
    },
    showTopBackButton: {
      type: Boolean,
      default: false
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
    xl: {
      type: [Boolean, String, Number],
      default: false
    }
  },

  data () {
    return {
      form: {
        newsType: {
          label: 'News Type',
          component: 'b-form-select',
          required: true,
          options: this.newsTypes
        },
        subject: {
          label: 'Subject',
          required: true
        },
        content: {
          label: 'Content',
          component: 'b-form-textarea',
          rows: 10
        }
      }
    }
  },

  validations () {
    const schema = {
      news: {
        newsType: { required },
        subject: { required },
        content: { }
      }
    }

    return schema
  },

  computed: {
    haveErrors () {
      return !isEmpty(this.serverErrors)
    },

    logoSrc () {
      return logo
    },

    backButtonVisible () {
      return this.showBackButton
    },

    topBackButtonVisible () {
      return this.backButtonVisible && this.showTopBackButton
    }
  },

  methods: {
    getValidationField (path) {
      return get(this.$v.news, path)
    },

    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `news_${snakeCase(key)}`
    },

    inputName (key) {
      return `news[${snakeCase(key)}]`
    },

    invalidFeedback (path) {
      return getMessage(this.getValidationField(path), this.state(path))
    },

    state (path) {
      const field = this.getValidationField(path)

      return field ? !field.$error : true
    },

    validate (e) {
      const func = ensureDebounceFunc('validateDebounceFunc', this, this.validateDebounced, DEBOUNCE_DELAY)

      func(e)
    },

    validateBeforeSubmit (e) {
      this.$v.$touch()

      if (!this.$v.$invalid) {
        e.target.submit()
      }
    },

    validateDebounced (event) {
      const path = event.target.dataset.path
      const field = this.getValidationField(path)

      field.$touch()
    }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      align-v="center"
      class="row-fluid"
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
          <a
            slot="header"
            href="/"
          >
            <b-card-img
              :src="logoSrc"
              alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
              top
            >
            </b-card-img>
          </a>
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
            :validation-method="validateBeforeSubmit"
            :token-name="tokenName"
            :token-value="tokenValue"
          >
            <b-button
              v-ujs-method="backMethod"
              v-if="topBackButtonVisible"
              :href="backHref"
              class="mb-4"
              variant="secondary"
            >
              <slot name="back">
                <fa-sprite
                  fixed-width
                  use="fas-fa-arrow-left"
                >
                </fa-sprite>
                Back
              </slot>
            </b-button>

            <div>
              <template v-for="(options, key) in form">
                <b-form-group
                  :data-required="options.required"
                  :id="inputGroupId(key)"
                  :invalid-feedback="invalidFeedback(key)"
                  :key="key"
                  :label="options.label"
                  :label-for="inputId(key)"
                  :state="state(key)"
                >
                  <component
                    v-model="$v.news[key].$model"
                    :autocomplete="options.autoComplete"
                    :data-path="key"
                    :id="inputId(key)"
                    :is="options.component || 'b-form-input'"
                    :name="inputName(key)"
                    :placeholder="options.placeholder"
                    :required="options.required"
                    :type="options.type || 'text'"
                    :options="options.options"
                    :rows="options.rows"
                    class="form-control"
                    @blur.native="validate"
                    @input.native="validate"
                  >
                  </component>
                </b-form-group>
              </template>
            </div>

            <b-button
              v-ujs-method="backMethod"
              v-if="backButtonVisible"
              :href="backHref"
              class="my-4"
              variant="secondary"
            >
              <slot name="back">
                <fa-sprite
                  fixed-width
                  use="fas-fa-arrow-left"
                >
                </fa-sprite>
                Back
              </slot>
            </b-button>

            <b-button
              v-b-modal.preview-modal
              class="my-4"
              variant="info"
            >
              <slot name="preview">
                Preview
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

            <b-modal
              id="preview-modal"
              title="Preview News"
              size="lg"
              ok-only
            >
              <div v-html="news.content"/>
            </b-modal>
          </rails-form>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.row-fluid {
  min-height: 100%;
}

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
