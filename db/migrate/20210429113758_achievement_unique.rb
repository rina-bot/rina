class AchievementUnique < ActiveRecord::Migration[6.1]
  def change
    execute <<~SQL
      TRUNCATE TABLE achievements_players;
    SQL

    add_index :achievements_players, %i[achievement_id player_id], unique: true
  end
end
