<script>
import includes from 'lodash/includes'
import isNumber from 'lodash/isNumber'
import PopupMixin from '../popup-mixin'
import split from 'lodash/split'
import { VARIANT_NORMAL } from '../variants'

const DEFAULT_DURATION = 4500

const CORNER_SIDE_TOP = 'top'
const CORNER_SIDE_RIGHT = 'right'

export const CORNER_TOP_RIGHT = 'top-right'

const CORNER_VSIDES = [CORNER_SIDE_TOP, 'bottom']
const CORNER_HSIDES = ['left', CORNER_SIDE_RIGHT]

export default {
  name: 'Notification',

  mixins: [PopupMixin],

  data () {
    return {
      corner: CORNER_TOP_RIGHT,
      duration: DEFAULT_DURATION,
      title: '',
      variant: VARIANT_NORMAL,
      verticalOffset: 0
    }
  },

  computed: {
    containerClasses () {
      const classes = [this.horizontalClass]

      if (this.customClass) {
        classes.push(this.customClass)
      }

      return classes
    },

    cornerSides () {
      const [vertical, horizontal] = split(this.corner, '-')

      return {
        vertical: includes(CORNER_VSIDES, vertical) ? vertical : CORNER_SIDE_TOP,
        horizontal: includes(CORNER_HSIDES, horizontal) ? horizontal : CORNER_SIDE_RIGHT
      }
    },

    horizontalClass () {
      return `notification--${this.cornerSides.horizontal}`
    },

    positionStyle () {
      let value

      value = this.verticalOffset
      if (!isNumber(value)) {
        value = parseInt(value, 10)
      }

      return { [this.cornerSides.vertical]: `${value}px` }
    }
  },

  methods: {
    onKeyDown (event) {
      switch (event.key) {
        case 'Backspace':
        case 'Delete':
          this.$refs.popup.clearTimer()
          break

        case 'Escape':
          if (!this.$refs.popup.closed) {
            this.$refs.popup.close()
          }
          break

        default:
          this.$refs.popup.startTimer()
      }
    }
  }
}
</script>

<template>
  <popup
    ref="popup"
    :class="containerClasses"
    :dismissible="dismissible"
    :duration="duration"
    :on-click="onClick"
    :on-close="onClose"
    :style="positionStyle"
    :variant="variant"
    :visible="visible"
    @closed="handleClosed"
  >
    <fa-sprite
      v-if="icon"
      fixed-width
      size="2x"
      :use="icon"
    />
    <div class="notification__group">
      <h5
        v-if="title"
        class="notification__title"
      >
        {{ title }}
      </h5>
      <div
        v-if="message"
        class="notification__content"
      >
        <slot>
          <p
            v-if="dangerouslyUseHTMLString"
            v-html="message"
          />
          <p v-else>{{ message }}</p>
        </slot>
      </div>
    </div>
  </popup>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

.alert {
  box-shadow: $modal-content-box-shadow-xs;
  transition:
    bottom 0.3s,
    left 0.3s,
    opacity 0.3s,
    right 0.3s,
    top 0.4s,
    transform 0.3s;

  > .fa-container {
    margin-right: 1rem;

    > .svg-inline--fa {
      vertical-align: 0.125em;
    }
  }
}

.notification--left {
  left: 16px;
}

.notification--right {
  right: 16px;
}

.notification__title {
  font-weight: bold;
  line-height: 1;
}

.notification__content {
  > p {
    line-height: 1;
    margin: 0;
  }
}

.alert-dismissible {
  .notification__group {
    // 1rem (left padding/margin) + 1.25rem (20px icon width)
    margin-right: 2.25rem;
  }
}

.popup-fade-enter {
  &.notification--left {
    left: 0;
    transform: translateX(-100%);
  }

  &.notification--right {
    right: 0;
    transform: translateX(100%);
  }
}

.popup-fade-leave-active {
  opacity: 0;
}
</style>
