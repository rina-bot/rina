class MessageGrantAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :message_grant_achievements, id: false do |t|
      t.references :message, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
    end
  end
end
