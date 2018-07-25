# frozen_string_literal: true

class LicenseSerializer < ActiveModel::Serializer
  attributes(
    :license_number, :front, :back, :photo_count
  )

  def front
    {
      lat: object.front_lat,
      long: object.front_long
    }
  end

  def back
    {
      lat: object.back_lat,
      long: object.back_long
    }
  end

  def photo_count
    object.photos.count
  end
end
