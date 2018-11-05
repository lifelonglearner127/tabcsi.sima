<script>
import { required } from 'vuelidate/lib/validators'
import ValidationMixin from '~/mixins/validation'

export default {
  name: 'UploadFile',

  mixins: [ValidationMixin('import')],

  data () {
    return { import: { file: '' } }
  },

  validations () {
    return { import: { file: { required } } }
  }
}
</script>

<template>
  <b-form-group
    id="import_file_group"
    data-required
    :invalid-feedback="invalidFeedback('file')"
    label="CSV File"
    label-for="import_file"
    :state="state('file')"
  >
    <b-form-file
      id="import_file"
      v-model="$v.import.file.$model"
      name="import[file]"
      placeholder="Choose a file"
      required
    />
  </b-form-group>
</template>

<style lang="scss" scoped>
</style>
