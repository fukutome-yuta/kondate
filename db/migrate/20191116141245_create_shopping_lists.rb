class CreateShoppingLists < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_lists do |t|
      t.references :user, foreign_key: true
      t.string :ingredient
      t.float :quantity
      t.string :unit
      t.boolean :bought, default: false

      t.timestamps
    end
  end
end
