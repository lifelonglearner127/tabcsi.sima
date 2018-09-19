<script>
import {
  ABORT_TEXT, BUTTON_MAP, BUTTON_NAMES, BUTTON_VALUES, CANCEL_TEXT, CLOSE, IGNORE_TEXT, NO_TEXT, OK, OK_CANCEL, OK_TEXT,
  RETRY, RETRY_CANCEL, RETRY_TEXT, YES, YES_NO, YES_NO_CANCEL, YES_TEXT
} from './buttons'

import { ICON_MAP, TYPE_VARIANT_MAP, TYPES, VARIANT_DANGER, VARIANT_PRIMARY, VARIANT_SECONDARY } from '../variants'
import IdMixin from 'bootstrap-vue/es/mixins/id'
import includes from 'lodash/includes'
import isFunction from 'lodash/isFunction'
import isString from 'lodash/isString'
import toLower from 'lodash/toLower'
import trim from 'lodash/trim'

const DEFAULT_ERROR_MESSAGE = 'Illegal input'
const INPUT_STATE_NONE = null
const INPUT_STATE_INVALID = 'invalid'

export const DEFAULTS = {
  abortButtonText: ABORT_TEXT,
  abortButtonVariant: VARIANT_DANGER,
  button: null,
  buttons: OK,
  callback: null,
  cancelButtonText: CANCEL_TEXT,
  cancelButtonVariant: VARIANT_SECONDARY,
  centerContent: false,
  customClass: null,
  dangerouslyUseHTMLString: false,
  errorMessage: '',
  iconOptions: null,
  ignoreButtonText: IGNORE_TEXT,
  ignoreButtonVariant: VARIANT_SECONDARY,
  inputErrorMessage: '',
  inputPattern: null,
  inputPlaceholder: '',
  inputState: INPUT_STATE_NONE,
  inputType: 'text',
  inputValidator: null,
  inputValue: null,
  message: '',
  noButtonText: NO_TEXT,
  noButtonVariant: VARIANT_DANGER,
  okButtonText: OK_TEXT,
  okButtonVariant: VARIANT_PRIMARY,
  retryButtonText: RETRY_TEXT,
  retryButtonVariant: VARIANT_PRIMARY,
  showInput: false,
  title: null,
  variant: null,
  visible: false,
  yesButtonText: YES_TEXT,
  yesButtonVariant: VARIANT_PRIMARY
}

export default {
  name: 'MessageBox',

  mixins: [IdMixin],

  props: {
    abortButtonText: {
      type: String,
      default: DEFAULTS.abortButtonText
    },

    abortButtonVariant: {
      type: String,
      default: DEFAULTS.abortButtonVariant
    },

    buttons: {
      type: String,
      default: DEFAULTS.buttons,

      validator (value) {
        return includes(BUTTON_VALUES, toLower(value))
      }
    },

    callback: {
      type: Function,
      default: DEFAULTS.callback
    },

    cancelButtonText: {
      type: String,
      default: DEFAULTS.cancelButtonText
    },

    cancelButtonVariant: {
      type: String,
      default: DEFAULTS.cancelButtonVariant
    },

    centerContent: {
      type: Boolean,
      default: DEFAULTS.centerContent
    },

    confirmButtonName: {
      type: String,

      default () {
        switch (this.buttons) {
          case OK:
          case OK_CANCEL:
            return OK

          case RETRY_CANCEL:
            return RETRY

          case YES_NO:
          case YES_NO_CANCEL:
            return YES

          default:
            return undefined
        }
      },

      validator (value) {
        return !value || includes(BUTTON_NAMES, toLower(trim(value)))
      }
    },

    customClass: {
      type: String,
      default: DEFAULTS.customClass
    },

    dangerouslyUseHTMLString: {
      type: Boolean,
      default: DEFAULTS.dangerouslyUseHTMLString
    },

    iconOptions: {
      type: [String, Array],
      default: DEFAULTS.iconOptions
    },

    ignoreButtonText: {
      type: String,
      default: DEFAULTS.ignoreButtonText
    },

    ignoreButtonVariant: {
      type: String,
      default: DEFAULTS.ignoreButtonVariant
    },

    inputErrorMessage: {
      type: String,
      default: DEFAULTS.inputErrorMessage
    },

    inputPattern: {
      type: RegExp,
      default: DEFAULTS.inputPattern
    },

    inputPlaceholder: {
      type: String,
      default: DEFAULTS.inputPlaceholder
    },

    inputType: {
      type: String,
      default: DEFAULTS.inputType
    },

    inputValidator: {
      type: Function,
      default: DEFAULTS.inputValidator
    },

    noButtonText: {
      type: String,
      default: DEFAULTS.noButtonText
    },

    noButtonVariant: {
      type: String,
      default: DEFAULTS.noButtonVariant
    },

    okButtonText: {
      type: String,
      default: DEFAULTS.okButtonText
    },

    okButtonVariant: {
      type: String,
      default: DEFAULTS.okButtonVariant
    },

    retryButtonText: {
      type: String,
      default: DEFAULTS.retryButtonText
    },

    retryButtonVariant: {
      type: String,
      default: DEFAULTS.retryButtonVariant
    },

    showInput: {
      type: Boolean,
      default: DEFAULTS.showInput
    },

    title: {
      type: String,
      default: DEFAULTS.title
    },

    variant: {
      type: String,
      default: DEFAULTS.variant,

      validator (value) {
        return !value || includes(TYPES, toLower(value))
      }
    },

    visible: {
      type: Boolean,
      default: DEFAULTS.visible
    },

    yesButtonText: {
      type: String,
      default: DEFAULTS.yesButtonText
    },

    yesButtonVariant: {
      type: String,
      default: DEFAULTS.yesButtonVariant
    }
  },

  data () {
    return {
      button: DEFAULTS.button,
      errorMessage: DEFAULTS.errorMessage,
      inputState: DEFAULTS.inputState,
      inputValue: DEFAULTS.inputValue,
      message: DEFAULTS.message
    }
  },

  computed: {
    containerClasses () {
      const classes = ['message-box']

      if (this.variant) {
        classes.push(`message-box--${this.variant}`)
      }

      if (this.centerContent) {
        classes.push('message-box--content-centered')
      }

      if (this.customClass) {
        classes.push(this.customClass)
      }

      return classes
    },

    icon () {
      return this.iconOptions || ICON_MAP[TYPE_VARIANT_MAP[this.variant]]
    },

    inputId () {
      return this.showInput ? this.safeId('_BV_input_') : null
    },

    modalButtons () {
      return BUTTON_MAP[this.buttons]
    }
  },

  watch: {
    inputValue: {
      immediate: true,

      handler (newVal, oldVal) {
        if (!this.showInput || newVal === oldVal) {
          return
        }

        this.$nextTick(() => {
          if (this.type === 'prompt' && newVal != null) {
            this.validate()
          }
        })
      }
    },

    visible (newVal, oldVal) {
      if (newVal === oldVal) {
        return
      }

      this.$refs.modal[newVal ? 'show' : 'hide']()
    }
  },

  methods: {
    _getButton (name) {
      return this.$refs[`${name}Button`][0]
    },

    buttonText (button, defaultText) {
      return this[`${button}ButtonText`] || defaultText
    },

    buttonVariant (button, defaultVariant) {
      return this[`${button}ButtonVariant`] || defaultVariant
    },

    handleButtonClick (event) {
      const button = event.target.dataset.button

      if (this.type === 'prompt' && button === this.confirmButtonName && !this.validate()) {
        return
      }

      this.button = button

      this.$refs.modal.hide()
    },

    handleHidden () {
      this.$nextTick(() => {
        if (this.button) {
          this.callback(this.button, this)
        }
      })
    },

    handleHide (event) {
      if (event.trigger === 'header-close') {
        this.button = CLOSE
      }
    },

    handleInputEnter () {
      if (!this.confirmButtonName) {
        return
      }

      const button = this._getButton(this.confirmButtonName)

      button.click()
    },

    handleShown () {
      if (this.showInput) {
        this.$refs.input.$el.focus()
      }
    },

    validate () {
      if (this.type === 'prompt') {
        const inputPattern = this.inputPattern

        if (inputPattern && !inputPattern.test(this.inputValue || '')) {
          this.errorMessage = this.inputErrorMessage || DEFAULT_ERROR_MESSAGE
          this.inputState = INPUT_STATE_INVALID

          return false
        }

        const inputValidator = this.inputValidator

        if (isFunction(inputValidator)) {
          const validateResult = inputValidator(this.inputValue)

          if (validateResult === false || isString(validateResult)) {
            this.errorMessage =
              isString(validateResult) ? validateResult : this.inputErrorMessage || DEFAULT_ERROR_MESSAGE

            this.inputState = INPUT_STATE_INVALID

            return false
          }
        }
      }

      this.errorMessage = ''
      this.inputState = INPUT_STATE_NONE

      return true
    }
  }
}
</script>

<template>
  <transition name="message-box-fade">
    <b-modal
      ref="modal"
      v-model="visible"
      :class="containerClasses"
      :hide-header="title == null"
      :id="safeId()"
      centered
      @hidden="handleHidden"
      @hide="handleHide"
      @shown="handleShown"
    >
      <template slot="modal-title">
        <fa-sprite
          v-if="icon && centerContent"
          :use="icon"
          class="message-box__icon"
          fixed-width
          size="lg"
        >
        </fa-sprite>
        {{ title }}
      </template>
      <fa-sprite
        slot="modal-header-close"
        fixed-width
        use="fas-fa-times"
      >
      </fa-sprite>
      <b-row
        align-v="center"
        no-gutters
      >
        <b-col
          v-if="icon && !centerContent && message"
          class="col-shrink"
        >
          <fa-sprite
            :use="icon"
            class="message-box__icon"
            fixed-width
            size="2x"
          >
          </fa-sprite>
        </b-col>
        <b-col class="col-auto">
          <div
            v-if="message"
            class="message-box__message"
          >
            <slot>
              <p
                v-if="dangerouslyUseHTMLString"
                v-html="message"
              />
              <p v-else>{{ message }}</p>
            </slot>
          </div>
          <div
            v-if="showInput"
            class="message-box__input"
          >
            <!-- `label-for` is provided to produce a `div` instead of a `fieldset`. -->
            <b-form-group
              :invalid-feedback="errorMessage"
              :label-for="inputId"
              :state="inputState"
            >
              <b-form-textarea
                v-if="inputType === 'textarea'"
                ref="input"
                v-model="inputValue"
                :id="inputId"
                :placeholder="inputPlaceholder"
                :state="inputState"
                rows="2"
              >
              </b-form-textarea>
              <b-form-input
                v-else
                ref="input"
                v-model="inputValue"
                :id="inputId"
                :placeholder="inputPlaceholder"
                :state="inputState"
                :type="inputType"
                @keydown.enter.native="handleInputEnter"
              >
              </b-form-input>
            </b-form-group>
          </div>
        </b-col>
      </b-row>
      <template slot="modal-footer">
        <b-button
          v-for="(value, key) in modalButtons"
          :data-button="key"
          :key="key"
          :ref="`${key}Button`"
          :variant="buttonVariant(key, value.variant)"
          @click="handleButtonClick"
        >
          {{ buttonText(key, value.text) }}
        </b-button>
      </template>
    </b-modal>
  </transition>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

$variants: (
  error: $danger,
  info: $info,
  success: $success,
  warning: $warning
);

$invalid-feedback-min-height: $form-feedback-font-size * $line-height-base / 100% + $form-feedback-margin-top;

.message-box {
  /deep/ .modal-header {
    align-items: center;

    .modal-title {
      line-height: 1;
    }

    .close {
      float: none;
      margin: 0 0 0 1rem;
      padding: 0;
    }
  }

  /deep/ .modal-body {
    .fa-container {
      margin-right: 1rem;

      > .svg-inline--fa {
        vertical-align: -0.25em;
      }
    }
  }
}

@each $variant, $color in $variants {
  .message-box--#{$variant} {
    .message-box__icon {
      color: $color;
    }
  }
}

.message-box__message {
  > p {
    margin: 0;
  }
}

.message-box__input {
  margin-top: 1rem;

  .form-group {
    margin-bottom: 0;

    .form-control:only-child {
      margin-bottom: $invalid-feedback-min-height;
    }
  }
}

.message-box--content-centered {
  /deep/ .modal-header {
    .modal-title {
      text-align: center;
      width: 100%;
    }
  }

  /deep/ .modal-body {
    text-align: center;
  }

  /deep/ .modal-footer {
    justify-content: center;
  }
}

.message-box-fade-enter-active {
  animation: message-box-fade-in 0.3s;
}

.message-box-fade-leave-active {
  animation: message-box-fade-out 0.3s;
}

@keyframes message-box-fade-in {
  0% {
    transform: translate3d(0, -20px, 0);
    opacity: 0;
  }

  100% {
    transform: translate3d(0, 0, 0);
    opacity: 1;
  }
}

@keyframes message-box-fade-out {
  0% {
    transform: translate3d(0, 0, 0);
    opacity: 1;
  }

  100% {
    transform: translate3d(0, -20px, 0);
    opacity: 0;
  }
}
</style>
