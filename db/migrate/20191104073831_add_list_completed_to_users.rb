class AddListCompletedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :list_completed, :boolean, default: false
  end
end
