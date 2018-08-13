# frozen_string_literal: true

class AddFullNamePhoneAndJobTitleToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.text :full_name, default: '', null: false
      t.string :phone
      t.string :job_title
    end
  end
end
