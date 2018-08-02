# frozen_string_literal: true

module TabcSi
  module V1
    class AuditFormsApi < Grape::API
      resources :audit_forms do
        desc(
          'Find Questions',
          detail: 'Retrieve self-inspection survey questions based on license' \
            ' number.',
          success: {
            model: Entities::AuditForm,
            message: 'A set of questions for a self-inspection survey.'
          }
        )
        params do
          requires :license_number, type: String, desc: 'Example: "MB123456"'
        end
        get :find do
          license = License.find_by(
            License.split_license_number(params[:license_number])
          )

          audit_form =
            AuditForm
            .includes(
              audit_form_questions: [
                { choices: %i[fields] },
                :conditions
              ]
            )
            .where(permit_name: license.permit_names)
            .first

          respond audit_form
        end
      end
    end
  end
end
