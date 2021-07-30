class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.text :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.text :keywords, array: true, default: [], null: false

      t.timestamps
    end

    create_table :achievements_players, id: false do |t|
      t.references :achievement
      t.references :player
    end

    create_table :achievement_triggers do |t|
      t.references :achievements
      t.string :trigger_type, null: false
      t.bigint :trigger_id, null: false
    end
  end
end
