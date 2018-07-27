# frozen_string_literal: true

module TabcSi
  module V1
    class AuditFormsApi < Grape::API
      resources :audit_forms do
        get :find do
          # audit_form =
          #   AuditForm.includes(
          #     audit_form_questions: [
          #       {
          #         choices: %i[fields]
          #       },
          #       :conditions
          #     ]
          #   )
          #     .find_by(permit_name: permit_name)
          #
          # if audit_form.blank?
          #   fail!(
          #     'Permit name is either unknown or is not associated with any' \
          #   ' questions.'
          #   )
          # end
          #
          # success! audit_form

          'GET audit_forms/find'
        end
      end
    end
  end
end
