<script>
import isFunction from 'lodash/isFunction'

export default {
  name: 'Popup',

  props: {
    dismissible: {
      type: Boolean,
      default: false
    },
    dismissLabel: {
      type: String,
      default: 'Close'
    },
    duration: {
      type: Number,
      default: 0
    },
    onClick: {
      type: Function,
      default: null
    },
    onClose: {
      type: Function,
      default: null
    },
    variant: {
      type: String,
      default: 'info'
    },
    visible: {
      type: Boolean,
      default: false
    }
  },

  data () {
    return {
      closed: false,
      timer: null
    }
  },

  computed: {
    alertVariant () {
      return `alert-${this.variant}`
    },

    classObject () {
      const classes = ['alert', this.alertVariant]

      if (this.dismissible) {
        classes.push('alert-dismissible')
      }

      return classes
    }
  },

  watch: {
    closed (newVal) {
      this.$emit('closed', newVal)
    }
  },

  mounted () {
    this.startTimer()
  },

  destroyed () {
    this.clearTimer()
  },

  methods: {
    clearTimer () {
      clearTimeout(this.timer)

      this.timer = null
    },

    close () {
      this.closed = true

      if (isFunction(this.onClose)) {
        this.onClose(this)
      }
    },

    handleClick () {
      if (isFunction(this.onClick)) {
        this.onClick()
      }
    },

    startTimer () {
      if (this.duration <= 0) {
        return
      }

      this.timer = setTimeout(
        () => {
          if (!this.closed) {
            this.close()
          }
        },
        this.duration
      )
    }
  }
}
</script>

<template>
  <transition name="popup-fade">
    <div
      v-show="visible"
      :class="classObject"
      aria-atomic="true"
      aria-live="polite"
      role="alert"
      @click="handleClick"
      @mouseenter="clearTimer"
      @mouseleave="startTimer"
    >
      <b-button-close
        v-if="dismissible"
        :aria-label="dismissLabel"
        @click.stop="close"
      >
        <div class="close-x">✖</div>
      </b-button-close>
      <slot />
    </div>
  </transition>
</template>

<style lang="scss" scoped>
.alert {
  align-items: center;
  display: flex;
  margin: 0;
  padding: 1rem;
  position: fixed;
}

.alert-dismissible {
  /deep/ > .close {
    float: none;
    font-size: inherit;
    font-weight: inherit;
    padding: 0;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
  }

  .close-x {
    display: inline-block;
    font-size: inherit;
    font-weight: bold;
    height: 1em;
    line-height: 1;
    vertical-align: 0.125em;
    width: 1.25em;
  }
}
</style>
