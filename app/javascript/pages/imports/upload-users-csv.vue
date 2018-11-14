<script>
import PageMixin from '~/mixins/page'
import UploadFile from '~/components/upload-file'
import UsersSessionsContainer from '~/components/users-sessions-container'

export default {
  name: 'ImportsUploadUsersCsv',

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
    title="Upload Users CSV"
    :token-name="tokenName"
    :token-value="tokenValue"
    :validation-method="validate"
  >
    <b-form-text class="text-left">
      <p>
        Tip: You can export a CSV from your ActiveDirectory or LDAP server, or create one manually. You might want to
        ask your IT department for this list.
      </p>
      <p>
        Syntax:<br>
        <code>"Full Name","user@example.com","(555) 555-5555","Job Title","MB859599,MB859418"</code>
      </p>
      <p>
        Required fields:
        <ul>
          <li>Full Name</li>
          <li>Email</li>
          <li>Job Title</li>
        </ul>
      </p>
      <p>
        Optional fields:
        <ul>
          <li>Phone</li>
          <li>Location CLPs</li>
        </ul>
      </p>
    </b-form-text>
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
