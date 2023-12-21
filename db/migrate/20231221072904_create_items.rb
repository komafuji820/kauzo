class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.text :content
      t.integer :category_id, null: false
      t.references :group, null: false, foreign_key: true
      t.timestamps
    end
  end
end