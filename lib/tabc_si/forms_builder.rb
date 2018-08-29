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
        build_forms

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

    def questions
      @questions ||= Builders::QuestionBuilderMap.new(json['questions'])
    end

    def forms
      @forms ||= Builders::FormBuilderMap.new(json['forms'])
    end

    def build_forms
      print '* Building forms...'

      questions.values.each(&:build)

      forms.values.each do |form|
        form.build(questions)
      end

      puts ' done.'
    end
  end
end
