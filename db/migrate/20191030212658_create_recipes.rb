class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.int :user_id
      t.boolean :cooked
      t.string :name
      t.string :url
      t.text :cooking_recipe
      t.date :cooked_at

      t.timestamps
    end
  end
end
