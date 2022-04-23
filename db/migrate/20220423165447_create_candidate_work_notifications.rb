class CreateCandidateWorkNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :candidate_work_notifications do |t|
      t.string :status
      t.references :candidate, null: false, foreign_key: true
      t.references :work_notification, null: false, foreign_key: true

      t.timestamps
    end
  end
end
