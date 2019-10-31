class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.boolean, :cooked
      t.string, :name
      t.string, :url
      t.string :schedule
      t.string :date

      t.timestamps
    end
  end
end
