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
      info: {
        title: 'TABC Audit/SI APIs',
        description: File.read(Rails.root.join('docs', 'v1_description.md')),
        contact_name: 'API Support',
        contact_email: 'support@neubus.com',
        license: 'Proprietary'
      },
      security_definitions: {
        tabc_si_auth: {
          type: 'oauth2',
          description: '',
          flows: {
            application: {
              tokenUrl: '/oauth/token'
            },
            password: {
              tokenUrl: '/oauth/token'
            }
          }
        }
      },
      security: { tabc_si_auth: [] },
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
      ],
      x: {
        tagGroups: [
          {
            name: 'General',
            tags: %w[push_tokens settings users]
          },
          {
            name: 'Questions',
            tags: %w[answers audit_forms]
          },
          {
            name: 'Vendors',
            tags: %w[distributors licenses vendors]
          }
        ]
      }
    )
  end
end
