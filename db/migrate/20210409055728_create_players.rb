class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.text :name
      t.text :line_uid
      t.text :line_reply_token
      t.integer :telegram_uid
      t.text :flags, array: true, default: [], null: false

      t.timestamps
    end
  end
end
