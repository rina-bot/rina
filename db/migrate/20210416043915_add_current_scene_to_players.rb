class AddCurrentSceneToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_reference :players, :current_scene, foreign_key: { to_table: :scenes }
  end
end
