<script>
import PageMixin from '~/mixins/page'
import UploadFile from '~/components/upload-file'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'ImportUploadCsv',

  components: {
    UploadFile,
    UsersSessionsContainer
  },

  mixins: [PageMixin],

  methods: {
    validate (e) {
      if (this.$refs.uploadForm && this.$refs.uploadForm.validateBeforeSubmit()) {
        e.target.submit()
      }
    }
  }
}
</script>

<template>
  <users-sessions-container
    :accept-charset="acceptCharset"
    :action="action"
    back-href="/"
    cols="12"
    enctype="multipart/form-data"
    :enforce-utf8="enforceUtf8"
    :hidden-method="hiddenMethod"
    :method="method"
    :server-errors="serverErrors"
    show-back-button
    show-top-back-button
    sm="6"
    submit-text="Upload"
    text-class="font-italic"
    title="Upload CSV"
    :token-name="tokenName"
    :token-value="tokenValue"
    :validation-method="validate"
  >
    <upload-file ref="uploadForm" />
  </users-sessions-container>
</template>

<style lang="scss" scoped>
@media only screen and (min-height: 968px) {
  /deep/ .container-row {
    align-items: center;
  }
}
</style>
