class CreateScenes < ActiveRecord::Migration[6.1]
  def change
    create_table :scenes do |t|
      t.text :rails_type
      t.text :title, null: false, default: ""
      t.integer :order, null: false, default: 0
      t.jsonb :meta, null: false, default: {}

      t.timestamps
    end
  end
end
