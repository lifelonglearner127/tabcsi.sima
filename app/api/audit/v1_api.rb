# frozen_string_literal: true

module Audit
  class V1Api < Grape::API
    version 'v1', using: :path

    mount V1::AnswersApi
    mount V1::AuditFormsApi
    mount V1::DistributorsApi
    mount V1::LicensesApi
    mount V1::PushTokensApi
    mount V1::SettingsApi
    mount V1::UsersApi
    mount V1::VendorsApi

    add_swagger_documentation(
      mount_path: '/docs_spec',
      doc_version: '1.0',
      info: { title: 'TABC Audit/SI APIs' }
    )
  end
end
