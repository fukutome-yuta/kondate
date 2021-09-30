class ChangeColumnNullToIngredient < ActiveRecord::Migration[5.2]
  def change
    change_column_null :ingredients, :recipe_id, true
  end
end
