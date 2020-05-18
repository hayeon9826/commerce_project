class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.integer :price
      t.text :description
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :items, :price
  end
end
