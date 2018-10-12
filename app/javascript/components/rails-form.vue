<script>
export default {
  name: 'RailsForm',

  props: {
    acceptCharset: {
      type: String,
      default: null
    },
    action: {
      type: String,
      default: null
    },
    enforceUtf8: Boolean,
    hiddenMethod: {
      type: String,
      default: null
    },
    method: {
      type: String,
      default: 'get'
    },
    tokenName: {
      type: String,
      default: 'authenticity_token'
    },
    tokenValue: {
      type: String,
      default: null
    },
    validationMethod: {
      type: Function,
      default: null
    }
  },

  methods: {
    handleSubmit (e) {
      if (this.validationMethod == null) {
        // submit the form if we don't have a validation callback
        e.target.submit()

        return
      }

      this.validationMethod(e)
    }
  }
}
</script>

<template>
  <b-form
    :accept-charset="acceptCharset"
    :action="action"
    class="needs-validation"
    :method="method"
    novalidate
    @submit.prevent="handleSubmit"
  >
    <input
      v-if="enforceUtf8"
      name="utf8"
      type="hidden"
      value="✓"
    >
    <input
      v-if="hiddenMethod"
      :value="hiddenMethod"
      name="_method"
      type="hidden"
    >
    <input
      v-if="tokenValue"
      :name="tokenName"
      :value="tokenValue"
      type="hidden"
    >
    <slot />
  </b-form>
</template>

<style lang="scss" scoped>
</style>
