class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.boolean :cooked, default: false
      t.string :name, null: false
      t.string :url
      t.text :cooking_recipe
      t.date :cooked_at

      t.timestamps
    end
  end
end
