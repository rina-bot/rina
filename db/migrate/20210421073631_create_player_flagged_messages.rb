class CreatePlayerFlaggedMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :player_flagged_messages, id: false do |t|
      t.references :player, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true
    end
  end
end
