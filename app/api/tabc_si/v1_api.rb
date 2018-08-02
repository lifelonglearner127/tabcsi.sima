# frozen_string_literal: true

module TabcSi
  class V1Api < Grape::API
    OAUTH_PROTOCOL = Rails.env.development? ? 'http' : 'https'
    OAUTH_HOST = "#{OAUTH_PROTOCOL}://#{Nenv.instance.application_host}"
    OAUTH_TOKEN_URL = "#{OAUTH_HOST}/oauth/token"

    prefix 'api'
    version 'v1', using: :path

    # mount V1::AnswersApi
    mount V1::AuditFormsApi
    # mount V1::DistributorsApi
    mount V1::LocationsApi
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
        oauth_client: {
          type: 'oauth2',
          description: File.read(Rails.root.join('docs', 'oauth_client.md')),
          flow: 'application',
          tokenUrl: OAUTH_TOKEN_URL,
          scopes: {}
        },
        oauth_password: {
          type: 'oauth2',
          description: File.read(Rails.root.join('docs', 'oauth_password.md')),
          flow: 'password',
          tokenUrl: OAUTH_TOKEN_URL,
          scopes: {}
        }
      },
      tags: [
        # {
        #   name: 'answers',
        #   description: 'Answers API'
        # },
        {
          name: 'audit_forms',
          description: 'Audit Forms (A.K.A. Questions) API'
        },
        # {
        #   name: 'distributors',
        #   description: 'Distributors API'
        # },
        {
          name: 'locations',
          description: 'Locations API'
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
            tags: %w[settings users push_tokens]
          },
          {
            name: 'Vendors',
            # tags: %w[locations vendors distributors]
            tags: %w[locations vendors]
          },
          {
            name: 'Questions',
            # tags: %w[answers audit_forms]
            tags: %w[audit_forms]
          }
        ]
      }
    )
  end
end
