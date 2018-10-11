<script>
import isEmpty from 'lodash/isEmpty'
import RailsForm from '~/components/rails-form'
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'NewsForm',

  components: { RailsForm },

  mixins: [ValidationMixin('news')],

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
    news: {
      type: Object,
      required: true
    },
    newsTypes: {
      type: Array,
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
          rows: 10,
          description: 'only secure source(https) are allowed to add an image'
        }
      }
    }
  },

  validations () {
    return {
      news: {
        newsType: { required },
        subject: { required },
        content: { }
      }
    }
  },

  computed: {
    backButtonVisible () {
      return this.showBackButton
    },

    haveErrors () {
      return !isEmpty(this.serverErrors)
    },

    topBackButtonVisible () {
      return this.backButtonVisible && this.showTopBackButton
    }
  },

  methods: {
    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `news_${snakeCase(key)}`
    },

    inputName (key) {
      return `news[${snakeCase(key)}]`
    },

    validateForm (e) {
      if (this.validateBeforeSubmit()) {
        e.target.submit()
      }
    }
  }
}
</script>

<template>
  <b-container class="h-100">
    <b-row
      align-h="center"
      class="container-row"
    >
      <b-col
        :cols="cols"
        :lg="lg"
        :md="md"
        :sm="sm"
        :xl="xl"
      >
        <b-card
          header-class="py-4"
          :title="title"
          title-tag="h5"
        >
          <a
            slot="header"
            href="/"
          >
            <b-card-img
              alt="Texas Alcoholic Beverage Commission: Texans Helping Businesses & Protecting Communities"
              src="@/assets/images/logo-white.png"
              top
            />
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
            :validation-method="validateForm"
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

            <div>
              <template v-for="(options, key) in form">
                <b-form-group
                  :id="inputGroupId(key)"
                  :key="key"
                  :data-required="options.required"
                  :invalid-feedback="invalidFeedback(key)"
                  :label="options.label"
                  :label-for="inputId(key)"
                  :description="options.description"
                  :state="state(key)"
                >
                  <component
                    :is="options.component || 'b-form-input'"
                    :id="inputId(key)"
                    v-model="$v.news[key].$model"
                    :autocomplete="options.autoComplete"
                    class="form-control"
                    :data-path="key"
                    :name="inputName(key)"
                    :placeholder="options.placeholder"
                    :required="options.required"
                    :type="options.type || 'text'"
                    :options="options.options"
                    :rows="options.rows"
                    @blur.native="validate"
                    @input.native="validate"
                  />
                </b-form-group>
              </template>
            </div>

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
              ok-only
              size="lg"
              title="Preview News"
            >
              <div v-html="news.content" />
            </b-modal>
          </rails-form>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.container-row {
  height: 100% !important;
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
