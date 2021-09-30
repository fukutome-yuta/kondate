class ChangeMenusRecipeIdNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :menus, :recipe_id, true
  end
end
