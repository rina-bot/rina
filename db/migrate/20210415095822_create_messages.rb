class CreateMessages < ActiveRecord::Migration[6.1]
  def up
    execute <<~SQL
      CREATE TYPE message_phase AS ENUM ('main', 'keyword', 'after');
    SQL

    create_table :messages do |t|
      t.references :scene, null: false, foreign_key: true
      t.column :phase, :message_phase, default: "main", null: false
      t.boolean :flag, default: false, null: false
      t.text :keywords, array: true, null: false, default: []
      t.text :text
      t.integer :delay, null: false, default: 0
      t.integer :order, null: false, default: 0

      t.timestamps
    end
  end

  def down
    execute <<~SQL
      DROP TYPE message_phase;
    SQL

    drop_table :messages
  end
end
