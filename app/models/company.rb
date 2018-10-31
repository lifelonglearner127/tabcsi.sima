# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :licenses, -> { order(:clp) }
  has_many :locations, -> { order(:name, :clp) }
  has_many :users, -> { with_discarded.order(:full_name) }

  validates :owner_name, presence: true, uniqueness: { case_sensitive: false }

  def admin_count
    users.where(role: :admin).size
  end

  def reset
    # don't reset if there are undiscarded users left
    return if users.kept.size.positive?

    transaction do
      users.find_in_batches do |batch|
        batch.each do |user|
          timestamp = Time.zone.now.strftime('%Y%m%d%H%M%S')

          user.update!(
            email: "#{user.email}.orphaned.#{timestamp}",
            orphaned: true,
            orphaned_at: Time.zone.now
          )
        end
      end

      users.update_all(company_id: nil)

      locations.update_all(
        inspected: false,
        inspected_at: nil,
        front_lat: nil,
        front_long: nil,
        back_lat: nil,
        back_long: nil,
        unpadded_diameter: nil,
        padded_diameter: nil,
        locked: false,
        locked_by_id: nil,
        locked_at: nil,
        updated_at: Time.zone.now
      )

      update!(name: nil, owned: false)
    end
  end
end
