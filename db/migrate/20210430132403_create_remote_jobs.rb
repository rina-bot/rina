class CreateRemoteJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :remote_jobs do |t|
      t.references :player, null: false, foreign_key: true
      t.text :channel, null: false
      t.uuid :request_id, null: false
      t.boolean :started, null: false, default: false
      t.boolean :finished, null: false, default: false
      t.index %w[player_id channel], unique: true

      t.timestamps
    end
  end
end
