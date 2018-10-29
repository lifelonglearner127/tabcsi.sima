# frozen_string_literal: true

class VerificationsController < ApplicationController
  layout false

  def show
    @pin = params[:pin]
  end
end
