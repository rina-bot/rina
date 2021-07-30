class DefaultDelay < ActiveRecord::Migration[6.1]
  def up
    change_column :messages, :delay, :float, null: true, default: nil
  end

  def down
    change_column :messages, :delay, :integer, null: false, default: 0
  end
end
