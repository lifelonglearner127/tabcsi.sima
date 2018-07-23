# frozen_string_literal: true

class LicenseSerializer < ActiveModel::Serializer
  attributes(
    :email, :license_number, :front_lat, :front_long, :back_lat, :back_long
  )

  def email
    object.user.email
  end
end
