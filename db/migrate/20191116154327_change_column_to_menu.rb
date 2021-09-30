class ChangeColumnToMenu < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :menus, :recipes
    remove_index :menus, :recipe_id
    remove_reference :menus, :recipe
  end
end
