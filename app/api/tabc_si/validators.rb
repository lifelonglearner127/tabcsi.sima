# frozen_string_literal: true

module TabcSi
  module Validators
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Id
      autoload :Entity
    end
  end
end

TabcSi::Validators.eager_load!
