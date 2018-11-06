# frozen_string_literal: true

if defined?(Slackistrano::Messaging)
  require 'active_support/all'

  module Slackistrano
    module Messaging
      class CustomMessaging < Base
        def payload_for(action)
          text = super[:text]

          attachment = {
            title: "Deployment #{action.to_s.titleize}",
            fields: [
              {
                title: 'Environment',
                value: stage,
                short: true
              },
              {
                title: 'Branch',
                value: branch,
                short: true
              },
              {
                title: 'Deployer',
                value: deployer,
                short: true
              }
            ],
            fallback: text
          }

          attachment[:color] =
            case action.to_sym
            when :updating, :updated, :reverted
              'good'
            when :reverting
              'warning'
            else
              'danger'
            end

          if %i[updated reverted failed].include?(action.to_sym)
            attachment[:fields] << {
              title: 'Elapsed Time',
              value: elapsed_time,
              short: true
            }
          end

          { attachments: [attachment] }
        end

        def deployer
          name = `git config user.name`.strip
          name = (Etc.getpwnam(ENV['USER']).gecos || super) if name.blank?
          name
        end
      end
    end
  end
end
