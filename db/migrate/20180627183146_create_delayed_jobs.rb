# frozen_string_literal: true

class CreateDelayedJobs < ActiveRecord::Migration[5.2]
  def change
    create_table(:delayed_jobs, force: true) do |t|
      # Allows some jobs to jump to the front of the queue.
      t.integer :priority, default: 0, null: false

      # Provides for retries, but still fail eventually.
      t.integer :attempts, default: 0, null: false

      # YAML-encoded string of the object that will do work.
      t.text :handler, null: false

      # Reason for last failure (see note below).
      t.text :last_error

      # When to run. Could be Time.current for immediately, or sometime in the
      # future.
      t.datetime :run_at

      # Set when a client is working on this object.
      t.datetime :locked_at

      # Set when all retries have failed (actually, by default, the record is
      # deleted instead)
      t.datetime :failed_at

      # Who is working on this object (if locked).
      t.string :locked_by

      # The name of the queue this job is in.
      t.string :queue

      t.timestamps null: true
    end

    add_index :delayed_jobs, %i[priority run_at], name: 'delayed_jobs_priority'
  end
end
