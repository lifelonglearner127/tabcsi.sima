# frozen_string_literal: true

module TabcSi
  class V1Api < Grape::API
    prefix 'api'
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
      info: { title: 'TABC Audit/SI APIs' },
      tags: [
        {
          name: 'answers',
          description: 'Answers API'
        },
        {
          name: 'audit_forms',
          description: 'Audit Forms (A.K.A. Questions) API'
        },
        {
          name: 'distributors',
          description: 'Distributors API'
        },
        {
          name: 'licenses',
          description: 'Licenses/Permits API'
        },
        {
          name: 'push_tokens',
          description: 'Push Tokens API'
        },
        {
          name: 'settings',
          description: 'Global settings for use by consuming applications.'
        },
        {
          name: 'users',
          description: 'Users API'
        },
        {
          name: 'vendors',
          description: 'Vendors API'
        }
      ]
    )
  end
end
