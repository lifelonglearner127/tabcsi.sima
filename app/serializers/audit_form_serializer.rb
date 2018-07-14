class AuditFormSerializer < ActiveModel::Serializer
  attributes :permit_name, :total_questions

  has_many :audit_form_questions, key: :questions

  def total_questions
    object.audit_form_questions.count
  end
end
