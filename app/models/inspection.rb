# frozen_string_literal: true

class Inspection < ApplicationRecord
  has_many :answers, -> { order(:id) }, dependent: :destroy
  belongs_to :audit_form, optional: true
  belongs_to :location
  belongs_to :user

  validates :started_at, presence: true

  after_create :lock_location

  def finish(finished_at, answers)
    answers.each do |question_number, a|
      answer = Answer.create!(
        inspection: self,
        question: Question.find_by(question_number: question_number),
        value: a[:value]
      )

      answer.pictures.attach(a[:pictures]) if a[:pictures].present?
    end

    update!(
      finished_at: finished_at,
      completed_at: Time.zone.now
    )

    unlock_location
  end

  private

  def lock_location
    location.update!(locked: true)
  end

  def unlock_location
    location.update!(locked: false)
  end
end
