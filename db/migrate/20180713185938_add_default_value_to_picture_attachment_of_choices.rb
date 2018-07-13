# frozen_string_literal: true

class AddDefaultValueToPictureAttachmentOfChoices < ActiveRecord::Migration[5.2]
  def change
    change_column_default :choices, :picture_attachment, from: nil, to: false
  end
end
