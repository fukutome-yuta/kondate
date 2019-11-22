class AddHowManyToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :how_many, :text
  end
end
