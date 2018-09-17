# frozen_string_literal: true

class Inspection < ApplicationRecord
  has_many(
    :answers,
    -> { with_attached_pictures.order(:question_id) },
    dependent: :destroy
  )

  belongs_to :audit_form
  belongs_to :license, optional: true
  belongs_to :location
  belongs_to :user

  validates :started_at, presence: true

  after_create :lock_location

  def finish(finished_at, answers)
    questions = Hash[
      audit_form.audit_form_questions.includes(:question).map do |afq|
        [afq.question_number, afq.question]
      end
    ]

    transaction do
      answers.each do |question_number, a|
        answer = Answer.create!(
          inspection: self,
          question: questions[question_number],
          value: a[:value]
        )

        answer.pictures.attach(a[:pictures]) if a[:pictures].present?
      end

      update!(
        finished_at: finished_at,
        completed_at: Time.zone.now,
        report_number: generate_report_number
      )

      unlock_location
    end
  end

  def cancel(reason)
    update!(
      cancelled_at: Time.zone.now,
      cancellation_reason: reason
    )

    unlock_location(inspected: false)
  end

  private

  def self.generate_report_number(location_id)
    fiscal_year = Setting.fiscal_year
    time = Time.zone.now
    random_sequence = SecureRandom.hex(1).upcase
    sum = time.month + time.day + time.hour + time.min + time.sec
    sequence = sum.to_s(16).rjust(2, '0').upcase

    "RCR#{fiscal_year}-#{location_id}-#{random_sequence}#{sequence}"
  end

  def generate_report_number
    self.class.generate_report_number(location.id)
  end

  def lock_location
    location.update!(
      locked: true,
      locked_by_id: user.id,
      locked_at: Time.zone.now
    )
  end

  def unlock_location(inspected: true)
    location.update!(
      locked: false,
      locked_by_id: nil,
      locked_at: nil,
      inspected: inspected,
      inspected_at: inspected ? Time.zone.now : nil
    )
  end
end
