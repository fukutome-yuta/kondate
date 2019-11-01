class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.references :recipe, foreign_key: true, null: false
      t.date :schedule
      t.string, :name
      t.string, :url
      t.boolean, :cooked, default: false

      t.timestamps
    end
  end
end
