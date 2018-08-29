# frozen_string_literal: true

module TabcSi
  class FormsBuilder
    include Singleton

    def self.run
      instance.run
    end

    def run
      Setting.deactivate_server!

      # allow rollback in case of error
      ApplicationRecord.transaction do
        map_answers
        map_inspections
        destroy_forms
        build_forms
        remap_inspections
        remap_answers

        Setting.forms_build_date = build_date
      end

      Setting.activate_server!
    end

    private

    def json
      @json ||= JSON.parse(File.read(Rails.root.join('lib', 'questions.json')))
    end

    def build_date
      @build_date ||= json['build_date'].to_i
    end

    # whether or not to use conditional attributes; e.g., 'inserted'
    def conditional_rebuild?
      build_date <= Setting.forms_build_date
    end

    def questions
      @questions ||= Builders::QuestionBuilderMap.new(json['questions'])
    end

    def forms
      @forms ||= Builders::FormBuilderMap.new(json['forms'])
    end

    def map_answers
      print '* Creating answers map...'

      @answers_map = Hash.new { |h, k| h[k] = [] }
      answers = Answer.includes(:question).all

      answers.each do |answer|
        question_number = answer.question&.question_number&.to_sym
        next if question_number.blank?
        @answers_map[question_number] << answer
      end

      puts ' done.'
    end

    def map_inspections
      print '* Creating inspections map...'

      @inspections_map = Hash.new { |h, k| h[k] = [] }
      inspections = Inspection.includes(:audit_form).all

      inspections.each do |inspection|
        permit_name = inspection.audit_form&.permit_name&.to_sym
        next if permit_name.blank?
        @inspections_map[permit_name] << inspection
      end

      puts ' done.'
    end

    def destroy_forms
      print '* Clearing form data...'

      Question.destroy_all
      AuditForm.destroy_all

      puts ' done.'
    end

    def build_forms
      print '* Building forms...'

      questions.values.each(&:build)

      forms.values.each do |form|
        form.build(questions)
      end

      puts ' done.'
    end

    def remap_inspections
      print '* Remapping inspections to new forms...'

      @inspections_map.each do |permit_name, inspections|
        inspections.each do |inspection|
          form_builder = forms[permit_name]
          inspection.update!(audit_form: form_builder.form)
        end
      end

      puts ' done.'
    end

    def remap_answers
      print '* Remapping answers to new questions...'

      @answers_map.each do |question_number, answers|
        answers.each do |answer|
          answer.update!(question: questions[question_number].question)
        end
      end

      puts ' done.'
    end
  end
end
