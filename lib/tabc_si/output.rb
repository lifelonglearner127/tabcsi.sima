# frozen_string_literal: true

module TabcSi
  module Output
    extend ActiveSupport::Concern

    included do
      attr_accessor :previous_line_length
      attr_accessor :current_line_length
    end

    def log(text)
      self.current_line_length += text.length

      print text
    end

    def log_line(text)
      log(text)
      reset_line(true)
    end

    def reset_line(new_line = false)
      if current_line_length < previous_line_length
        print(' ' * (previous_line_length - current_line_length))
      end

      print(new_line ? "\n" : "\r")

      self.previous_line_length = current_line_length
      self.current_line_length = 0
    end
  end
end
