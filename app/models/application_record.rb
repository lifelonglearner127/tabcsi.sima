# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Discard::Model

  default_scope -> { kept }

  has_paper_trail
end
