<script>
import PopupMixin from '../popup-mixin'

export default {
  name: 'Message',

  mixins: [PopupMixin],

  data () {
    return { centerContent: false }
  },

  computed: {
    containerClasses () {
      const classes = []

      if (this.centerContent) {
        classes.push('message--content-centered')
      }

      if (this.customClass) {
        classes.push(this.customClass)
      }

      return classes
    }
  },

  methods: {
    onKeyDown (event) {
      if (event.key !== 'Escape' || this.$refs.popup.closed) {
        return
      }

      this.$refs.popup.close()
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
    :variant="variant"
    :visible="visible"
    @closed="handleClosed"
  >
    <fa-sprite
      v-if="icon"
      fixed-width
      :use="icon"
    />
    <slot>
      <p
        v-if="dangerouslyUseHTMLString"
        v-html="message"
      />
      <p v-else>{{ message }}</p>
    </slot>
  </popup>
</template>

<style lang="scss" scoped>
.alert {
  left: 50%;
  top: 24px;
  transform: translateX(-50%);
  transition: opacity 0.3s, transform 0.4s;

  > .fa-container {
    margin-right: 1rem;

    > .svg-inline--fa {
      vertical-align: 0.125em;
    }
  }

  > p {
    line-height: 1;
    margin: 0;
  }
}

.message--content-centered {
  justify-content: center;
}

.alert-dismissible {
  > p {
    // 1rem (left padding/margin) + 1.25rem (20px icon width)
    margin-right: 2.25rem;
  }
}

.popup-fade-enter,
.popup-fade-leave-active {
  opacity: 0;
  transform: translate(-50%, -100%);
}
</style>
