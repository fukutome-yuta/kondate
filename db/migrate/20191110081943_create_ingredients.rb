class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true, null: false, index: true
      t.string :name
      t.float :quantity
      t.string :unit

      t.timestamps
    end
  end
end
