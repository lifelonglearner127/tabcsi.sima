# frozen_string_literal: true

module Api
  module V1
    class AuditFormsController < BaseV1Controller
      def find
        audit_form =
          AuditForm.includes(
            audit_form_questions: [
              {
                choices: %i[fields]
              },
              :conditions
            ]
          )
                   .find_by(permit_name: permit_name)

        if audit_form.blank?
          fail!(
            'Permit name is either unknown or is not associated with any' \
            ' questions.'
          )
        end

        success! audit_form: audit_form_as_json(audit_form)
      end

      private

      def permit_name
        @permit_name ||= params.require(:permit_name)
      end

      def audit_form_as_json(audit_form)
        ActiveModelSerializers::SerializableResource
          .new(audit_form, include: '**')
          .as_json
      end
    end
  end
end
