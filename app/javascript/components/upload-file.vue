<script>
import { required } from 'vuelidate/lib/validators'
import snakeCase from 'lodash/snakeCase'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'UploadFile',

  mixins: [ValidationMixin('import')],

  data () {
    return {
      import: { file: '' },
      form: {
        file: {
          label: 'CSV File',
          component: 'b-form-file',
          placeholder: 'Choose a file',
          required: true
        }
      }
    }
  },

  validations () {
    return { import: { file: { required } } }
  },

  methods: {
    inputGroupId (key) {
      return `${this.inputId(key)}_group`
    },

    inputId (key) {
      return `import_${snakeCase(key)}`
    },

    inputName (key) {
      return `import[${snakeCase(key)}]`
    }
  }
}
</script>

<template>
  <div>
    <template v-for="(options, key) in form">
      <b-form-group
        v-if="options.show == null ? true : options.show"
        :id="inputGroupId(key)"
        :key="key"
        :data-required="options.required"
        :invalid-feedback="invalidFeedback(key)"
        :label="options.label"
        :label-for="inputId(key)"
        :state="state(key)"
      >
        <component
          :is="options.component || 'b-form-input'"
          :id="inputId(key)"
          v-model="$v.import[key].$model"
          :required="options.required"
          :name="inputName(key)"
          :placeholder="options.placeholder"
        />
      </b-form-group>
    </template>
  </div>
</template>

<style lang="scss" scoped>
@import '~@/assets/stylesheets/variables';

</style>
