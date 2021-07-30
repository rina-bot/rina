class AchievementHasManyMessages < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :messages, :scenes

    rename_column :messages, :scene_id, :trigger_id
    add_column :messages, :trigger_type, :string

    execute <<~SQL
      UPDATE messages SET trigger_type ='Scene';
    SQL

    change_column :messages, :trigger_type, :string, null: false
  end
end
