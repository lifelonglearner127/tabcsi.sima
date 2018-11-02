<script>
import '~/vendor/tinymce'
import { maxLength, required } from 'vuelidate/lib/validators'
import Editor from '@tinymce/tinymce-vue'
import isEmpty from 'lodash/isEmpty'
import RailsForm from '~/components/rails-form'
import snakeCase from 'lodash/snakeCase'
import TabcCard from '~/components/tabc-card'
import ValidationMixin from '~/mixins/validation'

const SUBJECT_MAX_LENGTH = 255

export default {
  name: 'NewsForm',

  components: {
    Editor,
    RailsForm,
    TabcCard
  },

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
    enforceUtf8: Boolean,
    hiddenMethod: {
      type: String,
      default: null
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
    submitText: {
      type: String,
      default: null
    },
    text: {
      type: String,
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
          required: true,
          maxLength: SUBJECT_MAX_LENGTH
        }
      },
      submitDisabled: false,
      editorConfig: {
        branding: false,
        height: 300,
        menubar: false,
        plugins: ['image', 'link'],
        skin: false
      }
    }
  },

  validations () {
    return {
      news: {
        newsType: { required },
        subject: {
          required,
          maxLength: maxLength(SUBJECT_MAX_LENGTH)
        }
      }
    }
  },

  computed: {
    haveErrors () {
      return !isEmpty(this.serverErrors)
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
      if (this.submitDisabled) {
        return
      }

      this.submitDisabled = true

      if (this.validateBeforeSubmit()) {
        e.target.submit()
      } else {
        this.submitDisabled = false
      }
    }
  }
}
</script>

<template>
  <tabc-card
    cols="12"
    sm="8"
    :title="title"
  >
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
        v-ujs-method="'get'"
        class="mb-4"
        href="/"
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
              :maxlength="options.maxLength"
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

        <b-form-group
          id="news_content_group"
          label="Content"
          label-for="news_content"
          description="Only secure image sources or links (https) are allowed."
        >
          <b-textarea
            v-show="false"
            v-model="news.content"
            name="news[content]"
          />
          <editor
            id="news_content"
            v-model="news.content"
            :init="editorConfig"
          />
        </b-form-group>
      </div>

      <b-button
        v-ujs-method="'get'"
        class="my-4"
        href="/"
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
        :disabled="submitDisabled"
        type="submit"
        variant="tabc-primary"
      >
        <slot name="submit">
          {{ submitText }}
        </slot>
      </b-button>

      <b-form-text
        v-if="text || $slots.text"
        class="font-italic"
      >
        <slot name="text">
          {{ text }}
        </slot>
      </b-form-text>
    </rails-form>

    <b-modal
      id="preview-modal"
      ok-only
      size="lg"
      title="Preview News"
    >
      <h4>{{ news.subject }}</h4>
      <div v-html="news.content" />
    </b-modal>
  </tabc-card>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

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

/deep/ #preview-modal {
  .modal-body {
    img {
      max-width: 100%;
    }
  }
}
</style>
