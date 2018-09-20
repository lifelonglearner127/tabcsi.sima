<script>
import { onChange, onCut, onKeyDown, onPaste } from './input-control'

export default {
  name: 'VueInput',

  props: {
    format: {
      type: Function,
      required: true
    },
    parse: {
      type: Function,
      required: true
    },
    type: {
      type: String,
      required: true,
      default: 'text'
    },
    value: {
      type: String,
      default: ''
    }
  },

  computed: {
    valueText () {
      return this.format(this.value == null ? '' : this.value).text
    }
  },

  methods: {
    emitInput (value) {
      this.$emit('change', value)
      this.$emit('input', value)
    },

    onChange () {
      return onChange(this.$refs.input, this.parse, this.format, this.emitInput)
    },

    onCut () {
      return onCut(this.$refs.input, this.parse, this.format, this.emitInput)
    },

    onInput () {
      return onChange(this.$refs.input, this.parse, this.format, this.emitInput)
    },

    onKeyDown (e) {
      this.$emit('keydown', e)

      return onKeyDown(e, this.$refs.input, this.parse, this.format, this.emitInput)
    },

    onPaste () {
      return onPaste(this.$refs.input, this.parse, this.format, this.emitInput)
    }
  }
}
</script>

<template>
  <input
    ref="input"
    :value="valueText"
    @change="onChange"
    @cut="onCut"
    @input="onInput"
    @keydown="onKeyDown"
    @paste="onPaste"
  >
</template>

<style lang="scss" scoped>
</style>
