class AddColumnToMenu < ActiveRecord::Migration[5.2]
  def change
    add_reference :menus, :recipe, foreign_key: true
  end
end
