class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true, null: false, index: true
      t.string :name
      t.string :amount
      t.float :quantity
      t.integer :unit_id

      t.timestamps
    end
  end
end
