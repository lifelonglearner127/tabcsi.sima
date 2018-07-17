# frozen_string_literal: true

# This migration comes from active_storage (originally 20170806125915).
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string :key, null: false, index: { unique: true }
      t.text :filename, null: false
      t.text :content_type
      t.text :metadata
      t.bigint :byte_size, null: false
      t.text :checksum, null: false
      t.datetime :created_at, null: false
    end

    create_table :active_storage_attachments do |t|
      t.text :name, null: false
      t.references :record, null: false, polymorphic: true, index: false
      t.references :blob, null: false, index: true
      t.datetime :created_at, null: false

      t.index(
        %i[record_type record_id name blob_id],
        name: 'index_active_storage_attachments_on_record_and_name_and_blob',
        unique: true
      )
    end
  end
end
