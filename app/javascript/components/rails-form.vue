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
    enforceUtf8: {
      type: Boolean,
      default: false
    },
    hiddenMethod: {
      type: String,
      default: null
    },
    method: {
      type: String,
      default: 'get'
    },
    validationMethod: {
      type: Function,
      default: null
    },
    tokenName: {
      type: String,
      default: 'authenticity_token'
    },
    tokenValue: {
      type: String,
      default: null
    }
  }
}
</script>

<template>
  <b-form
    :accept-charset="acceptCharset"
    :action="action"
    :method="method"
    @submit.prevent="validationMethod"
    class="needs-validation"
    novalidate
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
